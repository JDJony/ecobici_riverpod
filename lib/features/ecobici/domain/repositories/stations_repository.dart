import '../entities/station.dart';

abstract class StationsRepository {
  Future<List<Station>> getStations();

  Future<Station?> getStationById(String id);
}
