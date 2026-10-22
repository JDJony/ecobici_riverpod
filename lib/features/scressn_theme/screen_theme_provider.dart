import 'package:flutter_riverpod/legacy.dart';

import 'screen_theme_dependencies.dart';
import 'screen_theme_view_model.dart';

export 'screen_theme_dependencies.dart';

final screenThemeVmProvider =
    StateNotifierProvider<ScreenThemeViewModel, bool>((ref) {
      final useCase = ref.watch(screenThemeUseCaseProvider);
      return ScreenThemeViewModel(useCase);
    });
