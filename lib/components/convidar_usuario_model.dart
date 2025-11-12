import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'convidar_usuario_widget.dart' show ConvidarUsuarioWidget;
import 'package:flutter/material.dart';

class ConvidarUsuarioModel extends FlutterFlowModel<ConvidarUsuarioWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for email_usuario widget.
  FocusNode? emailUsuarioFocusNode;
  TextEditingController? emailUsuarioTextController;
  String? Function(BuildContext, String?)? emailUsuarioTextControllerValidator;
  // Stores action output result for [Backend Call - API (newIncident)] action in Button widget.
  ApiCallResponse? resultApiIncident;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailUsuarioFocusNode?.dispose();
    emailUsuarioTextController?.dispose();
  }
}
