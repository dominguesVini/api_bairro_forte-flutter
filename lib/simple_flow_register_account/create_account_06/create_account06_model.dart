import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_account06_widget.dart' show CreateAccount06Widget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateAccount06Model extends FlutterFlowModel<CreateAccount06Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  late MaskTextInputFormatter phoneNumberMask;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // Stores action output result for [Backend Call - API (enviarCodigoVerificacao)] action in Button widget.
  ApiCallResponse? envioCodigo;
  // Stores action output result for [Backend Call - API (criarUsuario)] action in Image widget.
  ApiCallResponse? resultadoCriarUsuarioG;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
