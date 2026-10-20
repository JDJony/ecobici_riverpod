import '../entities/station.dart';
import '../repositories/stations_repository.dart';

class GetStations {
  const GetStations(this._repository);

  final StationsRepository _repository;

  Future<List<Station>> call() {
    return _repository.getStations();
  }
}
