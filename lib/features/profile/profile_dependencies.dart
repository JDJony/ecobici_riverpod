import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'profile_repository.dart';
import 'profile_usecase.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(secureStorageProvider));
});

final profileUseCaseProvider = Provider<ProfileUseCase>((ref) {
  return ProfileUseCase(ref.watch(profileRepositoryProvider));
});
