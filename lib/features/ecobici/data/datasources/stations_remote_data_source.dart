import '../models/station_model.dart';

abstract class StationsRemoteDataSource {
  Future<List<StationModel>> getStations();
}
