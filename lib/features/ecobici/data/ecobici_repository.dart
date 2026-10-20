import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../domain/models/station.dart';

class EcobiciRepository {
  Future<List<Station>> getStations() async {
    return const <Station>[Station(id: '1', name: 'Estacion 1', availableBikes: 5, availableDocks: 10, latitude: 19.4326, longitude: -99.1332)];
    //return const <Station>[];
    //throw UnimplementedError();
  }

  static const urlStations = "https://fakestoreapi.com/products";

  Future<List<Product>> getListProduct() async {
    try {
      final response = await http.get(Uri.parse(urlStations));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product(
          id: json['id'].toString(),
          title: json['title'],
          img: json['image'],
          price: (json['price'] as num).toDouble(),
        )).toList();
      }

    } catch (e) {
      return [];
    }
    return [];
  }

  static const urlStation = "https://apimetro.dev/movilidad/metro/estacion";

  Future<List<StationModel>> getStationsMeter() async {
    try {
      final response = await http.get(Uri.parse(urlStation));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final listStatios = data.map((json) => StationModel(
          id: json['estacion_id'],
          name: json['nombre'],
          alcaldia: json['alcaldia_municipio'],
          id_line: json['id_line'],
          no_estation: json['no_estacion'],
        )).toList();
        return listStatios;
      } 
        
    } catch (e) {
      return [];
    }
    return [];
  }
}