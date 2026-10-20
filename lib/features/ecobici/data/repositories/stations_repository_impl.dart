import '../../domain/entities/station.dart';
import '../../domain/repositories/stations_repository.dart';
import '../datasources/stations_remote_data_source.dart';

class StationsRepositoryImpl implements StationsRepository {
  StationsRepositoryImpl({required this.dataSource});

  final StationsRemoteDataSource dataSource;
  List<Station>? _cachedStations;

  @override
  Future<List<Station>> getStations() async {
    final models = await dataSource.getStations();
    final stations = models.map((model) => model.toEntity()).toList();
    _cachedStations = stations;
    return stations;
  }

  @override
  Future<Station?> getStationById(String id) async {
    final stations = _cachedStations ?? await getStations();
    for (final station in stations) {
      if (station.id == id) {
        return station;
      }
    }
    return null;
  }
}
