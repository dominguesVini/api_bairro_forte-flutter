import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'card_recuperar_senha_widget.dart' show CardRecuperarSenhaWidget;
import 'package:flutter/material.dart';

class CardRecuperarSenhaModel
    extends FlutterFlowModel<CardRecuperarSenhaWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (UFsIbge)] action in CardRecuperarSenha widget.
  ApiCallResponse? apiUfsIbge2;
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();
  }
}
