import 'package:flutter_riverpod/legacy.dart';

import 'screen_theme_usecase.dart';

class ScreenThemeViewModel extends StateNotifier<bool> {
  ScreenThemeViewModel(this._useCase) : super(false) {
    _loadSavedTheme();
  }

  final ScreenThemeUseCase _useCase;
  var _ignoreSavedTheme = false;

  Future<void> _loadSavedTheme() async {
    final isDarkMode = await _useCase.isDarkMode();
    if (!mounted || _ignoreSavedTheme) return;
    state = isDarkMode;
  }

  Future<void> toggleTheme() async {
    final nextTheme = !state;
    _ignoreSavedTheme = true;
    await _useCase.changeTheme(nextTheme);
    if (!mounted) return;
    state = nextTheme;
  }

  Future<void> resetDarkMode() async {
    _ignoreSavedTheme = true;
    await _useCase.resetDarkMode();
    if (!mounted) return;
    state = false;
  }
}
