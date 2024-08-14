import 'dart:async';
import 'package:flutter/material.dart';
import '../models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
   
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // Leer parámetro del scan seleccionado o leido del QR
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    // Posicionar cámara según coordenadas leidas (latitud y longitud)
    final CameraPosition puntoInicial = CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);
    // Marcadores
    Set<Marker> markers = <Marker>{Marker(markerId: const MarkerId('geo-location'), position: scan.getLatLng())};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined, color: Colors.white),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller.animateCamera(CameraUpdate.newCameraPosition(puntoInicial));
            }
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers, color: Colors.white),
        onPressed: () {
          // Cambiar tipo de mapa
          mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
          // Redibujar por cambio de estado
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}