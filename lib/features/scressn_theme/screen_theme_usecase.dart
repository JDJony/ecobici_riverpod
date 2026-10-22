import 'package:ecobici_riverpod/features/scressn_theme/screen_theme_repository.dart';

class ScreenThemeUseCase {
  const ScreenThemeUseCase(this._repository);
  final ScreenThemeRepository _repository;

  //Future<void> call(bool isDarkMode) => _repository.saveDarkMode(isDarkMode);

  Future<void> changeTheme(bool isDarkMode) async {
    await _repository.saveDarkMode(isDarkMode);
  }

  Future<bool> isDarkMode() async {
    return await _repository.readDarkMode();
  }

  Future<void> resetDarkMode() async {
    await _repository.resetDarkMode();
  }
}
