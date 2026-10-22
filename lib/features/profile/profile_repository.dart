import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'profile.dart';

abstract class ProfileRepository {
  Future<Profile> read();
  Future<void> save({required String name, required String token});
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._secureStorage);

  static const _boxName = 'profile_box';
  static const _nameKey = 'name';
  static const _tokenKey = 'secret_token';

  final FlutterSecureStorage _secureStorage;

  Future<Box<String>> _openBox() {
    if (Hive.isBoxOpen(_boxName)) {
      return Future.value(Hive.box<String>(_boxName));
    }
    return Hive.openBox<String>(_boxName);
  }

  @override
  Future<Profile> read() async {
    final box = await _openBox();
    final name = box.get(_nameKey, defaultValue: '') ?? '';
    final token = await _secureStorage.read(key: _tokenKey) ?? '';
    return Profile(name: name, token: token);
  }

  @override
  Future<void> save({required String name, required String token}) async {
    final box = await _openBox();
    await box.put(_nameKey, name);
    await _secureStorage.write(key: _tokenKey, value: token);
  }
}
