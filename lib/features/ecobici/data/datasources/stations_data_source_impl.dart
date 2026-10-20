import 'dart:convert';

import 'package:ecobici_riverpod/core/network/api_service.dart';
import 'package:ecobici_riverpod/features/ecobici/domain/models/station.dart';
import 'stations_data_source.dart';

class StationsDataSourceImpl implements StationsDataSource {

  StationsDataSourceImpl({required this.apiService});

  final APIService apiService;

  @override
  Future<List<StationModel>> getStations() async {
    try {
      final response = await apiService.get('https://apimetro.dev/movilidad/metro/estacion');
      final data = response.data;

      if(data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      final stations = (data['stations'] as List)
          .map((station) => StationModel.fromJson(station))
          .toList();
          
      return stations;
    } catch (e) {
      throw Exception('Failed to fetch stations: $e');
    }
  }
}