import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isLoading;

    return OutlinedButton(
      onPressed: isLoading
          ? null
          : () => ref.read(authProvider.notifier).signInWithGoogle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/google.png', width: 20, height: 20),
          const SizedBox(width: 12),
          const Text('Continuer avec Google'),
        ],
      ),
    );
  }
}
