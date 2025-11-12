import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'card_registro_incidentes_widget.dart' show CardRegistroIncidentesWidget;
import 'package:flutter/material.dart';

class CardRegistroIncidentesModel
    extends FlutterFlowModel<CardRegistroIncidentesWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  DateTime? datePicked;
  // State field(s) for DescriptionIncident widget.
  FocusNode? descriptionIncidentFocusNode;
  TextEditingController? descriptionIncidentTextController;
  String? Function(BuildContext, String?)?
      descriptionIncidentTextControllerValidator;
  // Stores action output result for [Backend Call - API (newIncident)] action in Button widget.
  ApiCallResponse? resultApi;
  // Stores action output result for [Backend Call - API (getIncident)] action in Button widget.
  ApiCallResponse? resultApiIncident;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    descriptionIncidentFocusNode?.dispose();
    descriptionIncidentTextController?.dispose();
  }
}
