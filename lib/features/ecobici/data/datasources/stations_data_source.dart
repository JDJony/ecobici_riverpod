import 'package:ecobici_riverpod/features/ecobici/domain/models/station.dart';

abstract class StationsDataSource {
  Future<List<StationModel>> getStations();
}