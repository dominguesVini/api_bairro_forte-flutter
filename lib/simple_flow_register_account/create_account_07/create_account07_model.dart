import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_account07_widget.dart' show CreateAccount07Widget;
import 'package:flutter/material.dart';

class CreateAccount07Model extends FlutterFlowModel<CreateAccount07Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Backend Call - API (criarUsuario)] action in Button widget.
  ApiCallResponse? resultadoCriarUsuario3;
  // Stores action output result for [Backend Call - API (verificarCodigoTwilio)] action in Button widget.
  ApiCallResponse? resultadoVerificarCodigo;
  // Stores action output result for [Backend Call - API (criarUsuario)] action in Button widget.
  ApiCallResponse? resultadoCriarUsuario;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
