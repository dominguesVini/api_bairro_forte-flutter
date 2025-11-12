import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'card_registro_cameras_widget.dart' show CardRegistroCamerasWidget;
import 'package:flutter/material.dart';

class CardRegistroCamerasModel
    extends FlutterFlowModel<CardRegistroCamerasWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DescriptionCamera widget.
  FocusNode? descriptionCameraFocusNode;
  TextEditingController? descriptionCameraTextController;
  String? Function(BuildContext, String?)?
      descriptionCameraTextControllerValidator;
  // Stores action output result for [Backend Call - API (newCamera)] action in Button widget.
  ApiCallResponse? resultadoCadCamera01;
  // Stores action output result for [Backend Call - API (getIncident)] action in Button widget.
  ApiCallResponse? resultApiIncident;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descriptionCameraFocusNode?.dispose();
    descriptionCameraTextController?.dispose();
  }
}
