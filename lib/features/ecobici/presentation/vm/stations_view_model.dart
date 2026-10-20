import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/station.dart';
import '../providers/stations_providers.dart';

final stationsViewModelProvider =
    AsyncNotifierProvider<StationsViewModel, List<Station>>(
      StationsViewModel.new,
    );

class StationsViewModel extends AsyncNotifier<List<Station>> {
  @override
  Future<List<Station>> build() {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<Station>> _load() {
    return ref.read(getStationsUseCaseProvider).call();
  }
}
