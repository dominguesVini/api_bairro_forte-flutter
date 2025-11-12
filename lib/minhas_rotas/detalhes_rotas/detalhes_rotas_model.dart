import '/flutter_flow/flutter_flow_util.dart';
import 'detalhes_rotas_widget.dart' show DetalhesRotasWidget;
import 'package:flutter/material.dart';

class DetalhesRotasModel extends FlutterFlowModel<DetalhesRotasWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
