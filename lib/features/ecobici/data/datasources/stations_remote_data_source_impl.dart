import 'package:ecobici_riverpod/core/network/api_service.dart';

import '../models/station_model.dart';
import 'stations_remote_data_source.dart';

class StationsRemoteDataSourceImpl implements StationsRemoteDataSource {
  StationsRemoteDataSourceImpl({required this.apiService});

  final APIService apiService;

  static const stationsUrl = 'https://apimetro.dev/movilidad/metro/estacion';

  @override
  Future<List<StationModel>> getStations() async {
    final response = await apiService.get(stationsUrl);
    final data = response.data;

    if (data is! List) {
      throw const FormatException('La respuesta de estaciones no es una lista');
    }

    return data.map((item) {
      return StationModel.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }
}
