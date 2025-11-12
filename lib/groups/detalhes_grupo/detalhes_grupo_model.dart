import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'detalhes_grupo_widget.dart' show DetalhesGrupoWidget;
import 'package:flutter/material.dart';

class DetalhesGrupoModel extends FlutterFlowModel<DetalhesGrupoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (atualizarGrupo)] action in Button widget.
  ApiCallResponse? apiResult40v2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
