// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

// Importa o pacote do Google Maps
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'dart:async';

class MapaDeLocalizacao extends StatefulWidget {
  const MapaDeLocalizacao({
    Key? key,
    this.width,
    this.height,
    required this.latitude, // Parâmetro para a latitude
    required this.longitude, // Parâmetro para a longitude
  }) : super(key: key);

  final double? width;
  final double? height;
  final double latitude;
  final double longitude;

  @override
  _MapaDeLocalizacaoState createState() => _MapaDeLocalizacaoState();
}

class _MapaDeLocalizacaoState extends State<MapaDeLocalizacao> {

  final Completer<gmaps.GoogleMapController> _controller = Completer();

  final Set<gmaps.Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    _markers.add(
      gmaps.Marker(
        markerId: gmaps.MarkerId('localizacao_selecionada'),
        position: gmaps.LatLng(widget.latitude, widget.longitude),
        infoWindow: gmaps.InfoWindow(
          title: 'Localização',
          snippet: 'Lat: ${widget.latitude}, Lng: ${widget.longitude}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gmaps.CameraPosition _initialPosition = gmaps.CameraPosition(
      target: gmaps.LatLng(widget.latitude, widget.longitude),
      zoom: 15.0,
    );

    return gmaps.GoogleMap(
      mapType: gmaps.MapType.normal,
      initialCameraPosition: _initialPosition,
      markers: _markers,
      onMapCreated: (gmaps.GoogleMapController controller) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        }
      },
    );
  }
}
