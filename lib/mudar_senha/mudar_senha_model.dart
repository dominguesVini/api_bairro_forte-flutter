import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'mudar_senha_widget.dart' show MudarSenhaWidget;
import 'package:flutter/material.dart';

class MudarSenhaModel extends FlutterFlowModel<MudarSenhaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for nova_senha widget.
  FocusNode? novaSenhaFocusNode;
  TextEditingController? novaSenhaTextController;
  late bool novaSenhaVisibility;
  String? Function(BuildContext, String?)? novaSenhaTextControllerValidator;
  // State field(s) for confirmar_senha widget.
  FocusNode? confirmarSenhaFocusNode;
  TextEditingController? confirmarSenhaTextController;
  late bool confirmarSenhaVisibility;
  String? Function(BuildContext, String?)?
      confirmarSenhaTextControllerValidator;

  @override
  void initState(BuildContext context) {
    novaSenhaVisibility = false;
    confirmarSenhaVisibility = false;
  }

  @override
  void dispose() {
    novaSenhaFocusNode?.dispose();
    novaSenhaTextController?.dispose();

    confirmarSenhaFocusNode?.dispose();
    confirmarSenhaTextController?.dispose();
  }
}
