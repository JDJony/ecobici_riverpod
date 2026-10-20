import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_service_provider.dart';
import '../../data/datasources/stations_remote_data_source.dart';
import '../../data/datasources/stations_remote_data_source_impl.dart';
import '../../data/repositories/stations_repository_impl.dart';
import '../../domain/repositories/stations_repository.dart';
import '../../domain/usecases/get_station_by_id.dart';
import '../../domain/usecases/get_stations.dart';

final stationsRemoteDataSourceProvider = Provider<StationsRemoteDataSource>((
  ref,
) {
  return StationsRemoteDataSourceImpl(
    apiService: ref.watch(apiServiceProvider),
  );
});

final stationsRepositoryProvider = Provider<StationsRepository>((ref) {
  return StationsRepositoryImpl(
    dataSource: ref.watch(stationsRemoteDataSourceProvider),
  );
});

final getStationsUseCaseProvider = Provider<GetStations>((ref) {
  return GetStations(ref.watch(stationsRepositoryProvider));
});

final getStationByIdUseCaseProvider = Provider<GetStationById>((ref) {
  return GetStationById(ref.watch(stationsRepositoryProvider));
});
