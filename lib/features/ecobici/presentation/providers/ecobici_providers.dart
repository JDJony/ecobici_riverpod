import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/ecobici_repository.dart';
import '../../domain/station.dart';

final ecobiciRepositoryProvider = Provider<EcobiciRepository>((ref) {
  return EcobiciRepository();
});

final stationsProvider = FutureProvider<List<Station>>((ref) {
  return ref.watch(ecobiciRepositoryProvider).getStations();
});

final stationDetailProvider = FutureProvider.family<Station?, String>((
  ref,
  stationId,
) async {
  final stations = await ref.watch(stationsProvider.future);
  for (final station in stations) {
    if (station.id == stationId) {
      return station;
    }
  }
  return null;
});