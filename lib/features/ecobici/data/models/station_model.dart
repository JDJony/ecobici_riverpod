import '../../domain/entities/station.dart';

class StationModel {
  const StationModel({
    required this.id,
    required this.name,
    required this.alcaldia,
    required this.lineId,
    required this.stationNumber,
  });

  final String id;
  final String name;
  final String alcaldia;
  final String lineId;
  final String stationNumber;

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: _asString(json['estacion_id']),
      name: _asString(json['nombre']),
      alcaldia: _asString(json['alcaldia_municipio']),
      lineId: _asString(json['linea_id']),
      stationNumber: _asString(json['num_estacion']),
    );
  }

  Station toEntity() {
    return Station(
      id: id,
      name: name,
      alcaldia: alcaldia,
      lineId: lineId,
      stationNumber: stationNumber,
    );
  }
}

String _asString(Object? value) => value?.toString() ?? '';
