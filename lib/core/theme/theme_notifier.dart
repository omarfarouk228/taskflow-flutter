import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/shared_prefs_provider.dart';

part 'theme_notifier.g.dart';

const _kThemeKey = 'theme_mode';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getString(_kThemeKey);
    return switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void toggle() {
    final next =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _persist(next);
  }

  void setMode(ThemeMode mode) => _persist(mode);

  void _persist(ThemeMode mode) {
    state = mode;
    ref.read(sharedPreferencesProvider).setString(_kThemeKey, mode.name);
  }
}
