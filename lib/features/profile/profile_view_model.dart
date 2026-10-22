import 'package:flutter_riverpod/legacy.dart';

import 'profile_usecase.dart';

enum ProfileStatus { loading, ready, saving, error }

class ProfileState {
  const ProfileState({
    this.name = '',
    this.token = '',
    this.status = ProfileStatus.loading,
    this.errorMessage,
  });

  final String name;
  final String token;
  final ProfileStatus status;
  final String? errorMessage;

  bool get hasData => name.isNotEmpty || token.isNotEmpty;

  ProfileState copyWith({
    String? name,
    String? token,
    ProfileStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      name: name ?? this.name,
      token: token ?? this.token,
      status: status ?? this.status,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._useCase) : super(const ProfileState()) {
    load();
  }

  final ProfileUseCase _useCase;
  var _ignoreLoadedProfile = false;

  Future<void> load() async {
    state = state.copyWith(status: ProfileStatus.loading, clearError: true);
    try {
      final profile = await _useCase.getProfile();
      if (!mounted || _ignoreLoadedProfile) return;
      state = ProfileState(
        name: profile.name,
        token: profile.token,
        status: ProfileStatus.ready,
      );
    } catch (_) {
      if (!mounted || _ignoreLoadedProfile) return;
      state = state.copyWith(
        status: ProfileStatus.error,
        errorMessage: 'No se pudo leer el perfil guardado.',
      );
    }
  }

  Future<bool> save({required String name, required String token}) async {
    final trimmedName = name.trim();
    final trimmedToken = token.trim();
    _ignoreLoadedProfile = true;
    state = state.copyWith(status: ProfileStatus.saving, clearError: true);
    try {
      await _useCase.saveProfile(name: trimmedName, token: trimmedToken);
      if (!mounted) return false;
      state = ProfileState(
        name: trimmedName,
        token: trimmedToken,
        status: ProfileStatus.ready,
      );
      return true;
    } catch (_) {
      if (!mounted) return false;
      state = state.copyWith(
        status: ProfileStatus.ready,
        errorMessage: 'No se pudo guardar el perfil.',
      );
      return false;
    }
  }
}
