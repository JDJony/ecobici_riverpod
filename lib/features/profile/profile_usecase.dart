import 'profile.dart';
import 'profile_repository.dart';

class ProfileUseCase {
  const ProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Profile> getProfile() => _repository.read();

  Future<void> saveProfile({required String name, required String token}) {
    return _repository.save(name: name, token: token);
  }
}
