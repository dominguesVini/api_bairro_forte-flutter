import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'enviar_report_widget.dart' show EnviarReportWidget;
import 'package:flutter/material.dart';

class EnviarReportModel extends FlutterFlowModel<EnviarReportWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (enviarReportDeFalha)] action in Button widget.
  ApiCallResponse? apiResultFaq;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
