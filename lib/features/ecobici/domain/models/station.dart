class Station {
  const Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.availableBikes,
    required this.availableDocks,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int availableBikes;
  final int availableDocks;
}

class Product {
  const Product({
    required this.id,
    required this.title,
    required this.img,
    required this.price,
  });

  final String id;
  final String title;
  final String img;
  final double price;
}

class StationModel {

  const StationModel({
    required this.id,
    required this.name,
    required this.alcaldia,
    required this.id_line,
    required this.no_estation,
  });

  final String id;
  final String name;
  final String alcaldia;
  final String id_line;
  final String no_estation;

  factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
    id: json['estacion_id'],
    name: json['nombre'],
    alcaldia: json['alcaldia_municipio'],
    id_line: json['id_line'],
    no_estation: json['no_estacion'],
  );
}