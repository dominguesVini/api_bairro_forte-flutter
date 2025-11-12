import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_camera_widget.dart' show AddCameraWidget;
import 'package:flutter/material.dart';

class AddCameraModel extends FlutterFlowModel<AddCameraWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - API (getIncident)] action in Button widget.
  ApiCallResponse? resultApiIncident;
  // Stores action output result for [Backend Call - API (newCamera)] action in Button widget.
  ApiCallResponse? resultadoCadCamera01;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
