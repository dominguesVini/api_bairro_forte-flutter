import '/flutter_flow/flutter_flow_util.dart';
import 'convidar_usuario_grupo_widget.dart' show ConvidarUsuarioGrupoWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ConvidarUsuarioGrupoModel
    extends FlutterFlowModel<ConvidarUsuarioGrupoWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for email_usuario widget.
  FocusNode? emailUsuarioFocusNode;
  TextEditingController? emailUsuarioTextController;
  late MaskTextInputFormatter emailUsuarioMask;
  String? Function(BuildContext, String?)? emailUsuarioTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    emailUsuarioFocusNode?.dispose();
    emailUsuarioTextController?.dispose();
  }
}
