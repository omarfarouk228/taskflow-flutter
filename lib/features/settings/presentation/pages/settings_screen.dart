import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../../../../core/utils/extensions.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final ThemeMode themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        children: [
          // ── Profil ──────────────────────────────────────
          if (user != null)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: context.colors.primaryContainer,
                child: Text(
                  user.initials,
                  style: TextStyle(color: context.colors.onPrimaryContainer),
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),

          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Text('APPARENCE',
                style: context.texts.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  letterSpacing: 1.2,
                )),
          ),

          // ── Thème ────────────────────────────────────────
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Thème'),
            subtitle: Text(switch (themeMode) {
              ThemeMode.light => 'Clair',
              ThemeMode.dark => 'Sombre',
              ThemeMode.system => 'Système',
            }),
            onTap: () => _showThemeDialog(context, ref, themeMode),
          ),

          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Text('NOTIFICATIONS',
                style: context.texts.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  letterSpacing: 1.2,
                )),
          ),

          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Rappels de tâches'),
            subtitle:
                const Text('Notification 1h avant l\'échéance'),
            value: true,
            onChanged: (_) {},
          ),

          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Text('COMPTE',
                style: context.texts.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  letterSpacing: 1.2,
                )),
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('À propos'),
            subtitle: const Text('TaskFlow v1.0.0'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.logout, color: context.colors.error),
            title: Text('Se déconnecter',
                style: TextStyle(color: context.colors.error)),
            onTap: () async {
              final confirm = await context.showConfirmDialog(
                title: 'Se déconnecter',
                content: 'Êtes-vous sûr de vouloir vous déconnecter ?',
                confirmLabel: 'Déconnecter',
                isDestructive: true,
              );
              if (confirm == true) {
                await ref.read(authProvider.notifier).signOut();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(
      BuildContext context, WidgetRef ref, ThemeMode current) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Choisir le thème'),
        content: RadioGroup<ThemeMode>(
          groupValue: current,
          onChanged: (m) {
            if (m != null) ref.read(themeProvider.notifier).setMode(m);
            Navigator.pop(context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map((mode) {
              final label = switch (mode) {
                ThemeMode.system => 'Système',
                ThemeMode.light => 'Clair',
                ThemeMode.dark => 'Sombre',
              };
              return RadioListTile<ThemeMode>(
                title: Text(label),
                value: mode,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
