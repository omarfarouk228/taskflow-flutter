import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:taskflow/app.dart';
import 'package:taskflow/features/auth/domain/entities/app_user.dart';
import 'package:taskflow/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskflow/features/auth/presentation/providers/auth_provider.dart';

// Faux repository d'authentification pour les tests
class FakeAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> get authStateChanges => Stream.value(null);
  @override
  AppUser? get currentUser => null;
  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<AppUser> signInWithGoogle() async => throw UnimplementedError();
  @override
  Future<void> signOut() async {}
  @override
  Future<void> sendPasswordResetEmail(String email) async {}
  @override
  Future<void> updateDisplayName(String displayName) async {}
  @override
  Future<void> updatePhoto(String photoUrl) async {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('TaskFlow Integration Tests', () {
    testWidgets('L\'app démarre et affiche l\'écran de login', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          ],
          child: const TaskFlowApp(),
        ),
      );
      await tester.pumpAndSettle();

      // L'utilisateur non connecté voit l'écran de login
      expect(find.text('Bonjour,'), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
    });

    testWidgets('Le formulaire de login valide les champs', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          ],
          child: const TaskFlowApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Taper sur "Se connecter" sans remplir
      await tester.tap(find.widgetWithText(ElevatedButton, 'Se connecter'));
      await tester.pump();

      // Les messages de validation doivent apparaître
      expect(find.text('Email requis'), findsOneWidget);
      expect(find.text('Mot de passe requis'), findsOneWidget);
    });

    testWidgets('Email invalide affiche une erreur', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          ],
          child: const TaskFlowApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Entrer un email invalide
      await tester.enterText(find.byType(TextFormField).first, 'emailinvalide');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Se connecter'));
      await tester.pump();

      expect(find.text('Email invalide'), findsOneWidget);
    });

    testWidgets('Navigation vers l\'écran d\'inscription', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          ],
          child: const TaskFlowApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Taper sur "Créer un compte"
      await tester.tap(find.text('Créer un compte'));
      await tester.pumpAndSettle();

      // Vérifier qu'on est sur l'écran d'inscription
      expect(find.text('Créer un compte'), findsWidgets);
      expect(find.text('Créer mon compte'), findsOneWidget);
    });
  });
}
