import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'perfil_widget.dart' show PerfilWidget;
import 'package:flutter/material.dart';

class PerfilModel extends FlutterFlowModel<PerfilWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataW9c = false;
  FFUploadedFile uploadedLocalFile_uploadDataW9c =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading_fotoPerfil = false;
  FFUploadedFile uploadedLocalFile_fotoPerfil =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_fotoPerfil = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
