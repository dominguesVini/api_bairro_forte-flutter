import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_account05_widget.dart' show CreateAccount05Widget;
import 'package:flutter/material.dart';

class CreateAccount05Model extends FlutterFlowModel<CreateAccount05Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for confirmaPassword widget.
  FocusNode? confirmaPasswordFocusNode;
  TextEditingController? confirmaPasswordTextController;
  late bool confirmaPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmaPasswordTextControllerValidator;
  // Stores action output result for [Backend Call - API (criarUsuario)] action in Image widget.
  ApiCallResponse? resultadoCriarUsuarioG;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    confirmaPasswordVisibility = false;
  }

  @override
  void dispose() {
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    confirmaPasswordFocusNode?.dispose();
    confirmaPasswordTextController?.dispose();
  }
}
