import 'package:ecobici_riverpod/features/scressn_theme/screen_theme_repository.dart';
import 'package:ecobici_riverpod/features/scressn_theme/screen_theme_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final screenThemeRepositoryProvider = Provider<ScreenThemeRepository>((ref) {
  return ScreenThemeRepositoryImpl();
});

final screenThemeUseCaseProvider = Provider<ScreenThemeUseCase>((ref) {
  final repository = ref.watch(screenThemeRepositoryProvider);
  return ScreenThemeUseCase(repository);
});
