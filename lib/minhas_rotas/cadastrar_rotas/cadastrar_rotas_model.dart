import '/flutter_flow/flutter_flow_util.dart';
import 'cadastrar_rotas_widget.dart' show CadastrarRotasWidget;
import 'package:flutter/material.dart';

class CadastrarRotasModel extends FlutterFlowModel<CadastrarRotasWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Slider widget.
  double? sliderValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
