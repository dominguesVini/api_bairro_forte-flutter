import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'mapa_dinamico_widget.dart' show MapaDinamicoWidget;
import 'package:flutter/material.dart';

class MapaDinamicoModel extends FlutterFlowModel<MapaDinamicoWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getPreferenceUser)] action in mapaDinamico widget.
  ApiCallResponse? resultadoPreference;
  // Stores action output result for [Backend Call - API (getIncident)] action in mapaDinamico widget.
  ApiCallResponse? resultadoCriarIncident;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
