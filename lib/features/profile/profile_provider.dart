import 'package:flutter_riverpod/legacy.dart';

import 'profile_dependencies.dart';
import 'profile_view_model.dart';

export 'profile_dependencies.dart';

final profileVmProvider = StateNotifierProvider<ProfileViewModel, ProfileState>(
  (ref) {
    final useCase = ref.watch(profileUseCaseProvider);
    return ProfileViewModel(useCase);
  },
);
