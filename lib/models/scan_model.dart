import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  int? id;
  String? tipo;
  String valor;

  ScanModel({this.id, this.tipo, required this.valor}) {
    tipo = valor.contains('http') ? 'http' : 'geo';
  }

  factory ScanModel.fromRawJson(String str) => ScanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  LatLng getLatLng() {
    // Extraer latitud y longitud del valor leido
    final latLng = valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);
    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
      id: json["id"],
      tipo: json["tipo"],
      valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "tipo": tipo,
      "valor": valor,
  };
}