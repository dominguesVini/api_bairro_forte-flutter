import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';

import 'index.dart';
import '/custom_code/actions/index.dart' as actions;

import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'dart:typed_data';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math';
import '/app_state.dart';
import '/backend/api_requests/api_calls.dart';
import '/auth/firebase_auth/auth_util.dart';

class CustomMapWidget extends StatefulWidget {
  final double searchRadius;

  const CustomMapWidget(
      {Key? key, this.searchRadius = 10000.0, double? width, double? height})
      : super(key: key);

  @override
  _CustomMapWidgetState createState() => _CustomMapWidgetState();
}

class _CustomMapWidgetState extends State<CustomMapWidget> {
  gmaps.GoogleMapController? _mapController;
  Set<gmaps.Marker> _markers = {};
  gmaps.LatLng? _currentPosition;
  bool _isReady = false;
  bool _firstLoadCompleted = false;
  bool _isFetching = false;
  Timer? _pollTimer;
  final Duration _pollInterval = Duration(seconds: 30);
  final Map<String, gmaps.BitmapDescriptor> _iconCache = {};
  ConfigUsuarioStruct? _lastConfigSnapshot;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _lastConfigSnapshot = FFAppState().configUsuario;
    FFAppState().addListener(_onAppStateChanged);
    _pollTimer = Timer.periodic(_pollInterval, (_) => _pollForUpdates());
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    FFAppState().removeListener(_onAppStateChanged);
    super.dispose();
  }

  void _onAppStateChanged() {
    if (!mounted) return;
    final currentConfig = FFAppState().configUsuario;
    if (_lastConfigSnapshot == null || currentConfig != _lastConfigSnapshot) {
      _lastConfigSnapshot = currentConfig;
      _fetchPreferencesAndIncidents().then((_) async {
        if (!mounted) return;
        await _loadMockMarkers();
        try {
          _mapController?.animateCamera(
            gmaps.CameraUpdate.newCameraPosition(
              gmaps.CameraPosition(target: _currentPosition!, zoom: 17.0),
            ),
          );
        } catch (e) {}
      });
      return;
    }

    _loadMockMarkers().then((_) {
      if (!mounted) return;
      try {
        _mapController?.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(target: _currentPosition!, zoom: 17.0),
          ),
        );
      } catch (e) {}
    });
  }

  Future<void> _getUserLocation() async {
    try {
      final userLoc =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      setState(() {
        _currentPosition = gmaps.LatLng(userLoc.latitude, userLoc.longitude);
      });

      try {
        await actions.adicionarLatLongAtualNaEstrutura();
      } catch (_) {}

      await _fetchPreferencesAndIncidents();
      await _loadMockMarkers(initialLoad: true);
      _updateCurrentLocationCoords(userLoc.latitude, userLoc.longitude);
      if (mounted) {
        _firstLoadCompleted = true;
        setState(() => _isReady = true);
      }
    } catch (e) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _currentPosition =
              gmaps.LatLng(position.latitude, position.longitude);
        });
        await _fetchPreferencesAndIncidents();
        await _loadMockMarkers(initialLoad: true);
        _updateCurrentLocationCoords(position.latitude, position.longitude);
        if (mounted) {
          _firstLoadCompleted = true;
          setState(() => _isReady = true);
        }
      } catch (err) {
      }
    }
  }

  Future<void> _pollForUpdates() async {
    if (!mounted) return;
    if (_isFetching) return;
    if (!_firstLoadCompleted) return;
    await _fetchPreferencesAndIncidents(onlyDiff: true);
    if (mounted) await _loadMockMarkers();
  }

  Future<void> _fetchPreferencesAndIncidents({bool onlyDiff = false}) async {
    if (_currentPosition == null) return;
    _isFetching = true;
    try {
      final pref = await ApiBairroForteGroup.getPreferenceUserCall.call(
        token: currentJwtToken,
      );
      if ((pref?.succeeded ?? false)) {
        try {
          FFAppState().configUsuario = ConfigUsuarioStruct(
            raio: getJsonField((pref?.jsonBody ?? ''), r'''$[0].radius_km'''),
            userId: valueOrDefault(currentUserDocument?.idUser, 0),
            periodoDas: ConfigUsuarioStruct.maybeFromMap(getJsonField(
                    (pref?.jsonBody ?? ''), r'''$[0].period_start_iso'''))
                ?.periodoDas,
            periodoAte: ConfigUsuarioStruct.maybeFromMap(getJsonField(
                    (pref?.jsonBody ?? ''), r'''$[0].period_end_iso'''))
                ?.periodoAte,
            categorias: (getJsonField(
                        (pref?.jsonBody ?? ''), r'''$[0].category''', true)
                    as List?)
                ?.map<String>((e) => e.toString())
                .toList()
                .cast<String>(),
            apenasGrupos:
                getJsonField((pref?.jsonBody ?? ''), r'''$[0].group_only'''),
          );
          FFAppState().update(() {});
        } catch (_) {}
      }

      final incidentResp = await ApiBairroForteGroup.getIncidentCall.call(
        raio: FFAppState().configUsuario.raio,
        longitude:
            FFAppState().filtros.longitude ?? _currentPosition!.longitude,
        latitude: FFAppState().filtros.latitude ?? _currentPosition!.latitude,
        typeList: FFAppState().configUsuario.categorias,
        token: currentJwtToken,
      );

      if ((incidentResp?.succeeded ?? false)) {
        final parsedIncidents = <IncidentesStruct>[];
        if (getJsonField(
                (incidentResp?.jsonBody ?? ''), r'''$.incidents[*]''') !=
            null) {
          parsedIncidents.addAll((getJsonField((incidentResp?.jsonBody ?? ''),
                      r'''$.incidents[*]''', true)!
                  .toList()
                  .map<IncidentesStruct?>(IncidentesStruct.maybeFromMap)
                  .toList() as Iterable<IncidentesStruct?>)
              .withoutNulls
              .toList()
              .cast<IncidentesStruct>());
        }

        final parsedCameras = <CameraStruct>[];
        if (getJsonField((incidentResp?.jsonBody ?? ''), r'''$.cameras[*]''') !=
            null) {
          parsedCameras.addAll((getJsonField((incidentResp?.jsonBody ?? ''),
                      r'''$.cameras[*]''', true)!
                  .toList()
                  .map<CameraStruct?>(CameraStruct.maybeFromMap)
                  .toList() as Iterable<CameraStruct?>)
              .withoutNulls
              .toList()
              .cast<CameraStruct>());
        }

        if (onlyDiff) {
          final existingIds =
              FFAppState().incidentes.map((e) => e.incidentId).toSet();
          final newOnes = parsedIncidents
              .where((i) => !existingIds.contains(i.incidentId))
              .toList();
          if (newOnes.isNotEmpty) {
            FFAppState().incidentes = [...FFAppState().incidentes, ...newOnes];
            FFAppState().update(() {});
          }

          final existingCamIds =
              FFAppState().cameras.map((c) => c.cameraId).toSet();
          final newCams = parsedCameras
              .where((c) => !existingCamIds.contains(c.cameraId))
              .toList();
          if (newCams.isNotEmpty) {
            FFAppState().cameras = [...FFAppState().cameras, ...newCams];
            FFAppState().update(() {});
          }
        } else {
          FFAppState().incidentes = parsedIncidents;
          FFAppState().cameras = parsedCameras;
          FFAppState().update(() {});
        }
      }
    } catch (e) {
    } finally {
      _isFetching = false;
    }
  }

  void _updateCurrentLocationCoords(double latitude, double longitude) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == "current_location");
      _markers.add(
        gmaps.Marker(
          markerId: gmaps.MarkerId("current_location"),
          position: gmaps.LatLng(latitude, longitude),
          infoWindow: gmaps.InfoWindow(title: "Minha Posição"),
          icon: gmaps.BitmapDescriptor.defaultMarkerWithHue(
            gmaps.BitmapDescriptor.hueBlue,
          ),
        ),
      );

      try {
        _mapController?.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(
              target: _currentPosition!,
              zoom: 17.0,
            ),
          ),
        );
      } catch (_) {}
    });
  }

  Future<void> _loadMockMarkers({bool initialLoad = false}) async {
    if (_currentPosition == null) return;
    Set<gmaps.Marker> newMarkers = {};

    final Set<String> missingIconTypes = {};
    for (var incidente in FFAppState().incidentes) {
      double lat = incidente.latitude;
      double lng = incidente.longitude;
      String tipo = incidente.type.isNotEmpty ? incidente.type : 'incidente';

      double distancia = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        lat,
        lng,
      );

      if (distancia <= widget.searchRadius) {
        String snippet = 'Distância: ${distancia.toStringAsFixed(2)} km';
        if ((incidente.status).isNotEmpty) {
          snippet += '\nCategoria: ${incidente.status}';
        }
        if ((incidente.description).isNotEmpty) {
          snippet += '\nDescrição: ${incidente.description}';
        }

        final icon = _iconCache[tipo] ?? gmaps.BitmapDescriptor.defaultMarker;
        if (!_iconCache.containsKey(tipo)) missingIconTypes.add(tipo);

        newMarkers.add(
          gmaps.Marker(
            markerId: gmaps.MarkerId(incidente.incidentId.toString()),
            position: gmaps.LatLng(lat, lng),
            icon: icon,
            infoWindow: gmaps.InfoWindow(
              title: incidente.type.isNotEmpty ? incidente.type : 'Relatório',
              snippet: snippet,
            ),
          ),
        );
      }
    }

    final Set<gmaps.Marker> cameraMarkers = {};
    for (var cam in FFAppState().cameras) {
      try {
        double lat = cam.latitude;
        double lng = cam.longitude;
        double distancia = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lat,
          lng,
        );
        if (distancia <= widget.searchRadius) {
          final tipo = 'camera';
          final icon = _iconCache[tipo] ?? gmaps.BitmapDescriptor.defaultMarker;
          if (!_iconCache.containsKey(tipo)) missingIconTypes.add(tipo);
          String snippetCam = 'Distância: ${distancia.toStringAsFixed(2)} km';
          if (cam.shared == true) snippetCam += '\nCompartilhada';
          if (cam.description != null && cam.description.isNotEmpty) {
            snippetCam += '\nDescrição: ${cam.description}';
          }
          cameraMarkers.add(
            gmaps.Marker(
              markerId: gmaps.MarkerId('camera_${cam.cameraId}'),
              position: gmaps.LatLng(lat, lng),
              icon: icon,
              infoWindow: gmaps.InfoWindow(
                title: cam.description?.isNotEmpty == true
                    ? cam.description
                    : 'Câmera',
                snippet: snippetCam,
              ),
            ),
          );
        }
      } catch (_) {}
    }

    if (!initialLoad) {
      setState(() {
        _markers = {
          ...newMarkers,
          ...cameraMarkers,
          ..._markers.where((m) => m.markerId.value == "current_location"),
        };
      });
    }

    if (missingIconTypes.isNotEmpty) {
      for (var tipo in missingIconTypes) {
        try {
          final desc = await _getCustomMarker(tipo, null);
          _iconCache[tipo] = desc;
        } catch (e) {}
      }

      final Set<gmaps.Marker> finalMarkers = {};
      for (var incidente in FFAppState().incidentes) {
        double lat = incidente.latitude;
        double lng = incidente.longitude;
        String tipo = incidente.type.isNotEmpty ? incidente.type : 'incidente';

        double distancia = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lat,
          lng,
        );

        if (distancia <= widget.searchRadius) {
          String snippet = 'Distância: ${distancia.toStringAsFixed(2)} km';
          if ((incidente.status).isNotEmpty) {
            snippet += '\nCategoria: ${incidente.status}';
          }
          if ((incidente.description).isNotEmpty) {
            snippet += '\nDescrição: ${incidente.description}';
          }

          finalMarkers.add(
            gmaps.Marker(
              markerId: gmaps.MarkerId(incidente.incidentId.toString()),
              position: gmaps.LatLng(lat, lng),
              icon: _iconCache[tipo] ?? gmaps.BitmapDescriptor.defaultMarker,
              infoWindow: gmaps.InfoWindow(
                title: incidente.type.isNotEmpty ? incidente.type : 'Relatório',
                snippet: snippet,
              ),
            ),
          );
        }
      }

      final Set<gmaps.Marker> finalCameraMarkers = {};
      for (var cam in FFAppState().cameras) {
        try {
          double lat = cam.latitude;
          double lng = cam.longitude;
          double distancia = _calculateDistance(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            lat,
            lng,
          );
          if (distancia <= widget.searchRadius) {
            final tipo = 'camera';
            String snippetCam = 'Distância: ${distancia.toStringAsFixed(2)} km';
            if (cam.shared == true) snippetCam += '\nCompartilhada';
            if (cam.description != null && cam.description.isNotEmpty) {
              snippetCam += '\nDescrição: ${cam.description}';
            }
            finalCameraMarkers.add(
              gmaps.Marker(
                markerId: gmaps.MarkerId('camera_${cam.cameraId}'),
                position: gmaps.LatLng(lat, lng),
                icon: _iconCache[tipo] ?? gmaps.BitmapDescriptor.defaultMarker,
                infoWindow: gmaps.InfoWindow(
                  title: cam.description?.isNotEmpty == true
                      ? cam.description
                      : 'Câmera',
                  snippet: snippetCam,
                ),
              ),
            );
          }
        } catch (_) {}
      }

      setState(() {
        _markers = {
          ...finalMarkers,
          ...finalCameraMarkers,
          ..._markers.where((m) => m.markerId.value == "current_location"),
        };
      });
    } else {
      setState(() {
        _markers = {
          ...newMarkers,
          ...cameraMarkers,
          ..._markers.where((m) => m.markerId.value == "current_location"),
        };
      });
    }

    try {
      _mapController?.animateCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(target: _currentPosition!, zoom: 17.0),
        ),
      );
    } catch (e) {}
  }

  Future<gmaps.BitmapDescriptor> _getCustomMarker(
      String tipo, DateTime? dataCriacao) async {
    if (tipo == "camera") {
      return await _getCustomIcon('assets/images/camera_icon_modal.png', 40);
    }
    return await _getCustomIcon('assets/images/information.png', 40);
  }

  Future<gmaps.BitmapDescriptor> _getCustomIcon(
      String assetPath, int size) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final Codec codec = await instantiateImageCodec(bytes, targetWidth: size);
    final FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image originalImage = frameInfo.image;

    final int totalSize = size + 20;
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint()..color = const Color(0xFFB0B0B0);

    canvas.drawCircle(
      Offset(totalSize / 2, totalSize / 2),
      totalSize / 2,
      paint,
    );

    final double imageOffset = (totalSize - size) / 2;
    canvas.drawImage(originalImage, Offset(imageOffset, imageOffset), Paint());

    final ui.Image finalImage =
        await recorder.endRecording().toImage(totalSize, totalSize);
    final ByteData? imgBytes =
        await finalImage.toByteData(format: ImageByteFormat.png);

    return gmaps.BitmapDescriptor.fromBytes(imgBytes!.buffer.asUint8List());
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371;
    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _degToRad(double deg) {
    return deg * (pi / 180);
  }

  Color _getHeatMapBaseColor(int incidentCount) {
    switch (incidentCount) {
      case 0:
        return Colors.transparent;
      case 1:
        return const Color(0xFF4FC3F7);
      case 2:
        return const Color(0xFF29B6F6);
      case 3:
        return const Color(0xFF66BB6A);
      case 4:
        return const Color(0xFFFFEE58);
      case 5:
        return const Color(0xFFFFB74D);
      case 6:
        return const Color(0xFFFF8A65);
      case 7:
        return const Color(0xFFE57373);
      case 8:
        return const Color(0xFFEF5350);
      default:
        return const Color(0xFFD32F2F);
    }
  }

  Color _getStrokeColor(int incidentCount) {
    switch (incidentCount) {
      case 0:
        return Colors.transparent;
      case 1:
        return const Color(0xFF0288D1).withOpacity(0.8);
      case 2:
        return const Color(0xFF0277BD).withOpacity(0.85);
      case 3:
        return const Color(0xFF388E3C).withOpacity(0.85);
      case 4:
        return const Color(0xFFFBC02D).withOpacity(0.9);
      case 5:
        return const Color(0xFFFF9800).withOpacity(0.9);
      case 6:
        return const Color(0xFFFF5722).withOpacity(0.95);
      case 7:
        return const Color(0xFFD32F2F).withOpacity(0.95);
      case 8:
        return const Color(0xFFC62828).withOpacity(1.0);
      default:
        return const Color(0xFFB71C1C).withOpacity(1.0);
    }
  }

  double _getCircleRadius(int incidentCount) {
    switch (incidentCount) {
      case 0:
        return 0;
      case 1:
        return 600;
      case 2:
        return 800;
      case 3:
        return 1000;
      case 4:
        return 1200;
      case 5:
        return 1400;
      case 6:
        return 1600;
      case 7:
        return 1800;
      case 8:
        return 2000;
      default:
        return 2200;
    }
  }

  int _getStrokeWidth(int incidentCount) {
    if (incidentCount >= 7) return 4;
    if (incidentCount >= 4) return 3;
    if (incidentCount >= 2) return 2;
    return 1;
  }

  List<gmaps.Circle> _generateHeatMapCircles() {
    Map<String, int> regionCounts = _countIncidentsByRegion();
    List<gmaps.Circle> heatCircles = [];
    const double fadeMaxKm = 3.0;

    regionCounts.forEach((key, count) {
      if (count == 0) return;
      var latLng = key.split('_');
      double lat = double.parse(latLng[0]);
      double lng = double.parse(latLng[1]);

      double distanceFromCenter = 0.0;
      try {
        distanceFromCenter = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lat,
          lng,
        );
      } catch (_) {
        distanceFromCenter = 0.0;
      }

      final double normalized =
          (distanceFromCenter / fadeMaxKm).clamp(0.0, 1.0);
      final Color baseColor = _getHeatMapBaseColor(count);
      double baseOpacity;
      switch (count) {
        case 1:
          baseOpacity = 0.30;
          break;
        case 2:
          baseOpacity = 0.40;
          break;
        case 3:
          baseOpacity = 0.50;
          break;
        case 4:
          baseOpacity = 0.55;
          break;
        case 5:
          baseOpacity = 0.60;
          break;
        case 6:
          baseOpacity = 0.65;
          break;
        case 7:
          baseOpacity = 0.70;
          break;
        case 8:
          baseOpacity = 0.75;
          break;
        default:
          baseOpacity = 0.80;
      }

      double finalOpacity =
          (baseOpacity * (1.0 - normalized)).clamp(0.04, baseOpacity);
      final Color fillColor = baseColor.withOpacity(finalOpacity);
      final Color strokeColor = _getStrokeColor(count)
          .withOpacity((finalOpacity + 0.2).clamp(0.12, 1.0));
      double radius = _getCircleRadius(count);
      int strokeWidth = _getStrokeWidth(count);

      heatCircles.add(
        gmaps.Circle(
          circleId: gmaps.CircleId(key),
          center: gmaps.LatLng(lat, lng),
          radius: radius,
          fillColor: fillColor,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
        ),
      );
    });

    return heatCircles;
  }

  Map<String, int> _countIncidentsByRegion() {
    Map<String, int> regionCounts = {};
    const double radiusInKm = 3.0;
    const double gridSize = 0.01;

    for (var incidente in FFAppState().incidentes) {
      double gridLat = (incidente.latitude / gridSize).round() * gridSize;
      double gridLng = (incidente.longitude / gridSize).round() * gridSize;
      String key =
          "${gridLat.toStringAsFixed(3)}_${gridLng.toStringAsFixed(3)}";

      double distancia = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        incidente.latitude,
        incidente.longitude,
      );

      if (distancia <= radiusInKm) {
        regionCounts[key] = (regionCounts[key] ?? 0) + 1;
      }
    }

    return regionCounts;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady || _currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }

    return gmaps.GoogleMap(
      key: ValueKey(_markers.length),
      mapType: gmaps.MapType.satellite,
      initialCameraPosition: gmaps.CameraPosition(
        target: _currentPosition!,
        zoom: 16.0,
      ),
      markers: _markers,
      circles: _generateHeatMapCircles().toSet(),
      onMapCreated: (gmaps.GoogleMapController controller) {
        _mapController = controller;
        _fetchPreferencesAndIncidents();
      },
    );
  }
}