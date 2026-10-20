import '../entities/station.dart';
import '../repositories/stations_repository.dart';

class GetStationById {
  const GetStationById(this._repository);

  final StationsRepository _repository;

  Future<Station?> call(String id) {
    return _repository.getStationById(id);
  }
}
