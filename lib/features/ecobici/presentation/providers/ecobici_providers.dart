import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/ecobici_repository.dart';
import '../../domain/models/station.dart';


final ecobiciRepositoryProvider = Provider<EcobiciRepository>((ref) {
  return EcobiciRepository();
});

final stationsProvider = FutureProvider<List<Station>>((ref) {
  return ref.watch(ecobiciRepositoryProvider).getStations();
});

final listProductProvider = FutureProvider<List<Product>>((ref) {
  return ref.watch(ecobiciRepositoryProvider).getListProduct();
});

final stationsMeterProvider = FutureProvider<List<StationModel>>((ref) {
  return ref.watch(ecobiciRepositoryProvider).getStationsMeter();
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