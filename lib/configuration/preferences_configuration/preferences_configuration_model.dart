import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'preferences_configuration_widget.dart'
    show PreferencesConfigurationWidget;
import 'package:flutter/material.dart';

class PreferencesConfigurationModel
    extends FlutterFlowModel<PreferencesConfigurationWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Slider widget.
  double? sliderValue;
  // State field(s) for selecionarCategoria widget.
  List<String>? selecionarCategoriaValue;
  FormFieldController<List<String>>? selecionarCategoriaValueController;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - API (Saveprefrences)] action in Button widget.
  ApiCallResponse? resultadoSalvarPrerenc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
