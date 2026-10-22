import 'package:ecobici_riverpod/core/shared_preferences/shared_preferences_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScreenThemeRepository {
  Future<bool> readDarkMode();
  Future<void> saveDarkMode(bool isDarkMode);
  Future<void> resetDarkMode();
}

class ScreenThemeRepositoryImpl implements ScreenThemeRepository {

  final keyTheme = SharedPreferencesTheme.darkModeKey;

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();


  @override
  Future<bool> readDarkMode() async => await _prefs.getBool(keyTheme) ?? false;

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    await _prefs.setBool(keyTheme, isDarkMode);
  }

  @override
  Future<void> resetDarkMode() async {
    await _prefs.remove(keyTheme);
  }
}