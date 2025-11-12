// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

bool selecionarLocalizacao(gmaps.LatLng location, String itemCreate) {
  if (itemCreate == 'CAMERA') {
    print(
        "Localização selecionada: ${location.latitude}, ${location.longitude}");

    FFAppState().updateCameraStruct(
      (e) => e
        ..latitude = location.latitude
        ..longitude = location.longitude,
    );

    return true;
  } else {
    return false;
  }
}

// MODIFY CODE ONLY ABOVE THIS LINE

/// MODIFY CODE ONLY ABOVE THIS LINE

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
