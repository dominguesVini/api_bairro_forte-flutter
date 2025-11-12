import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'criar_grupo_widget.dart' show CriarGrupoWidget;
import 'package:flutter/material.dart';

class CriarGrupoModel extends FlutterFlowModel<CriarGrupoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for nomeGrupo widget.
  FocusNode? nomeGrupoFocusNode;
  TextEditingController? nomeGrupoTextController;
  String? Function(BuildContext, String?)? nomeGrupoTextControllerValidator;
  // Stores action output result for [Backend Call - API (criarGruposComUsuarios)] action in Button widget.
  ApiCallResponse? resultadoCriarGrupo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nomeGrupoFocusNode?.dispose();
    nomeGrupoTextController?.dispose();
  }
}
