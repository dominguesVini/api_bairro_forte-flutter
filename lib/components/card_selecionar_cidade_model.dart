import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'card_selecionar_cidade_widget.dart' show CardSelecionarCidadeWidget;
import 'package:flutter/material.dart';

class CardSelecionarCidadeModel
    extends FlutterFlowModel<CardSelecionarCidadeWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (UFsIbge)] action in CardSelecionarCidade widget.
  ApiCallResponse? apiUfsIbge2;
  // State field(s) for DropDown widget.
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  // Stores action output result for [Backend Call - API (municipiosIbge)] action in DropDown widget.
  ApiCallResponse? apiCidadesUf;
  // State field(s) for DropDown widget.
  int? dropDownValue2;
  FormFieldController<int>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
