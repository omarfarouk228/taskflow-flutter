import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Stream<AppUser?> get authStateChanges =>
      _auth.authStateChanges().map(_mapUser);

  @override
  AppUser? get currentUser => _mapUser(_auth.currentUser);

  AppUser? _mapUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      createdAt: user.metadata.creationTime,
    );
  }

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(credential.user)!;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
      }
      return _mapUser(_auth.currentUser)!;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw const ValidationException('Connexion annulée');

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return _mapUser(userCredential.user)!;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    await _auth.currentUser?.updateDisplayName(displayName);
    await _auth.currentUser?.reload();
  }

  @override
  Future<void> updatePhoto(String photoUrl) async {
    await _auth.currentUser?.updatePhotoURL(photoUrl);
    await _auth.currentUser?.reload();
  }

  Exception _mapFirebaseError(FirebaseAuthException e) {
    return switch (e.code) {
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' =>
        const ValidationException('Email ou mot de passe incorrect.'),
      'email-already-in-use' =>
        const ValidationException('Cet email est déjà utilisé.'),
      'weak-password' =>
        const ValidationException('Mot de passe trop faible (min 6 car.).'),
      'invalid-email' =>
        const ValidationException('Email invalide.'),
      'network-request-failed' =>
        const NetworkException('Pas de connexion internet.'),
      'too-many-requests' =>
        const ServerException('Trop de tentatives. Réessayez plus tard.'),
      'operation-not-allowed' =>
        const ServerException('Connexion par email désactivée. Activez-la dans la Firebase Console.'),
      'internal-error' =>
        const ServerException('Erreur Firebase interne. Vérifiez que Email/Password est activé dans la Firebase Console.'),
      _ => ServerException('[${e.code}] ${e.message ?? 'Erreur d\'authentification.'}'),
    };
  }
}
