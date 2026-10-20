import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/station.dart';
import '../providers/stations_providers.dart';
import 'stations_view_model.dart';

final stationDetailViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<StationDetailViewModel, Station?, String>(
      StationDetailViewModel.new,
    );

class StationDetailViewModel extends AsyncNotifier<Station?> {
  StationDetailViewModel(this.stationId);

  final String stationId;

  @override
  Future<Station?> build() async {
    await ref.watch(stationsViewModelProvider.future);
    return ref.read(getStationByIdUseCaseProvider).call(stationId);
  }
}
