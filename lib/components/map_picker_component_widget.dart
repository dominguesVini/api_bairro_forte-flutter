import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'map_picker_component_model.dart';
export 'map_picker_component_model.dart';

class MapPickerComponentWidget extends StatefulWidget {
  const MapPickerComponentWidget({
    super.key,
    required this.itemCriar,
  });

  final String? itemCriar;

  @override
  State<MapPickerComponentWidget> createState() =>
      _MapPickerComponentWidgetState();
}

class _MapPickerComponentWidgetState extends State<MapPickerComponentWidget> {
  late MapPickerComponentModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapPickerComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: custom_widgets.MapPickerWidget(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.7,
          itemCreate: widget.itemCriar,
        ),
      ),
    );
  }
}
