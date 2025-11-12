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

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

class MapPickerWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final String? itemCreate;

  MapPickerWidget({this.width, this.height, required this.itemCreate});

  @override
  _MapPickerWidgetState createState() => _MapPickerWidgetState();
}

class _MapPickerWidgetState extends State<MapPickerWidget> {
  gmaps.LatLng? selectedLocation;
  bool isLoading = true;
  Set<gmaps.Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Serviço de localização desativado.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      selectedLocation = gmaps.LatLng(position.latitude, position.longitude);
      markers.add(
        gmaps.Marker(
          markerId: gmaps.MarkerId("selectedLocation"),
          position: selectedLocation!,
        ),
      );
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF1A1A1A),
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isSmallScreen ? 60 : 70),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF6C63FF).withOpacity(0.3)),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
              ),
            ),
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF6C63FF).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Color(0xFF6C63FF), size: 18),
                  SizedBox(width: 6),
                  Text(
                    "Selecionar Local",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Stack(
          children: [
            // Mapa otimizado para diferentes tamanhos de tela
            Container(
              margin: EdgeInsets.only(
                top: isSmallScreen ? 70 : 80,
                left: 12,
                right: 12,
                bottom: isSmallScreen ? 80 : 90,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6C63FF).withOpacity(0.2),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: isLoading
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2A2A2A),
                            Color(0xFF1A1A1A),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF6C63FF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Color(0xFF6C63FF).withOpacity(0.3)),
                              ),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF6C63FF)),
                                strokeWidth: 2.5,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Carregando mapa...",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : gmaps.GoogleMap(
                      initialCameraPosition: gmaps.CameraPosition(
                        target: selectedLocation!,
                        zoom: 16,
                      ),
                      markers: markers,
                      onTap: (gmaps.LatLng location) {
                        setState(() {
                          selectedLocation = location;
                          markers.clear();
                          markers.add(
                            gmaps.Marker(
                              markerId: gmaps.MarkerId("selectedLocation"),
                              position: location,
                              icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
                                gmaps.BitmapDescriptor.hueViolet,
                              ),
                            ),
                          );
                        });
                      },
                      mapType: gmaps.MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                    ),
            ),

            // Painel de informações compacto
            if (!isLoading && selectedLocation != null)
              Positioned(
                top: isSmallScreen ? 85 : 95,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Color(0xFF6C63FF).withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.my_location,
                              color: Color(0xFF6C63FF), size: 16),
                          SizedBox(width: 6),
                          Text(
                            "Coordenadas",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Lat: ${selectedLocation!.latitude.toStringAsFixed(4)}",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 10),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Lng: ${selectedLocation!.longitude.toStringAsFixed(4)}",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Instrução de uso mais compacta
            if (!isLoading)
              Positioned(
                bottom: isSmallScreen ? 95 : 105,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: Color(0xFF6C63FF).withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, color: Color(0xFF6C63FF), size: 16),
                      SizedBox(width: 6),
                      Text(
                        "Toque no mapa para selecionar",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: selectedLocation != null
            ? Container(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (selectedLocation != null) {
                      if (widget.itemCreate == 'CAMERA') {
                        FFAppState().updateCameraStruct(
                          (e) => e..latitude = selectedLocation!.latitude,
                        );
                        FFAppState().updateCameraStruct(
                          (e) => e..longitude = selectedLocation!.longitude,
                        );
                      } else {
                        FFAppState().updateIncidentStruct(
                          (e) => e..latitude = selectedLocation!.latitude,
                        );
                        FFAppState().updateIncidentStruct(
                          (e) => e..longitude = selectedLocation!.longitude,
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                  backgroundColor: Color(0xFF6C63FF),
                  elevation: 6,
                  icon: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 18),
                  ),
                  label: Text(
                    "Confirmar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
