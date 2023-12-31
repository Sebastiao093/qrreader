import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

class ScanModel {
    
    int? id;
    String? tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        required this.valor,
    }) {
      if(this.valor.contains('https')){
        this.tipo = 'http';
      } else {
        this.tipo = 'geo';
      }
    }

    LatLng getLagLng(){

      final latLng = valor.substring(4).split(',');
      final lat = double.parse( latLng[0]);
      final lng = double.parse( latLng[1]);

      return LatLng(lat, lng);

    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
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
