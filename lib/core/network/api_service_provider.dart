import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_service.dart';

final apiServiceProvider = Provider<APIService>((ref) {
  final service = APIService();
  ref.onDispose(service.dispose);
  return service;
});
