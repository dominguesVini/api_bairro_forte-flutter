import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/card_registro_cameras_widget.dart';
import '/components/card_registro_incidentes_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mapa_dinamico_model.dart';
export 'mapa_dinamico_model.dart';

class MapaDinamicoWidget extends StatefulWidget {
  const MapaDinamicoWidget({super.key});

  static String routeName = 'mapaDinamico';
  static String routePath = '/mapaDinamico';

  @override
  State<MapaDinamicoWidget> createState() => _MapaDinamicoWidgetState();
}

class _MapaDinamicoWidgetState extends State<MapaDinamicoWidget> {
  late MapaDinamicoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapaDinamicoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      FFAppState().LatLongRegistro = currentUserLocationValue;
      safeSetState(() {});
      await actions.adicionarLatLongAtualNaEstrutura();
      _model.resultadoPreference =
          await ApiBairroForteGroup.getPreferenceUserCall.call(
        token: currentJwtToken,
      );

      FFAppState().configUsuario = ConfigUsuarioStruct(
        raio: getJsonField(
          (_model.resultadoPreference?.jsonBody ?? ''),
          r'''$[0].radius_km''',
        ),
        userId: valueOrDefault(currentUserDocument?.idUser, 0),
        periodoDas: ConfigUsuarioStruct.maybeFromMap(getJsonField(
          (_model.resultadoPreference?.jsonBody ?? ''),
          r'''$[0].period_start_iso''',
        ))?.periodoDas,
        periodoAte: ConfigUsuarioStruct.maybeFromMap(getJsonField(
          (_model.resultadoPreference?.jsonBody ?? ''),
          r'''$[0].period_end_iso''',
        ))?.periodoAte,
        categorias: (getJsonField(
          (_model.resultadoPreference?.jsonBody ?? ''),
          r'''$[0].category''',
          true,
        ) as List?)
            ?.map<String>((e) => e.toString())
            .toList()
            .cast<String>(),
        apenasGrupos: getJsonField(
          (_model.resultadoPreference?.jsonBody ?? ''),
          r'''$[0].group_only''',
        ),
      );
      FFAppState().userId = getJsonField(
        (_model.resultadoPreference?.jsonBody ?? ''),
        r'''$[0].user.user_id''',
      );
      FFAppState().update(() {});
      _model.resultadoCriarIncident =
          await ApiBairroForteGroup.getIncidentCall.call(
        raio: FFAppState().configUsuario.raio,
        longitude: FFAppState().filtros.longitude,
        latitude: FFAppState().filtros.latitude,
        typeList: FFAppState().configUsuario.categorias,
        token: currentJwtToken,
      );
      
      if ((_model.resultadoCriarIncident?.succeeded ?? true)) {
        if (getJsonField(
              (_model.resultadoCriarIncident?.jsonBody ?? ''),
              r'''$.incidents[*]''',
            ) !=
            null) {
          FFAppState().incidentes = (getJsonField(
            (_model.resultadoCriarIncident?.jsonBody ?? ''),
            r'''$.incidents[*]''',
            true,
          )!
                  .toList()
                  .map<IncidentesStruct?>(IncidentesStruct.maybeFromMap)
                  .toList() as Iterable<IncidentesStruct?>)
              .withoutNulls
              .toList()
              .cast<IncidentesStruct>();
          FFAppState().update(() {});
        }
        if (getJsonField(
              (_model.resultadoCriarIncident?.jsonBody ?? ''),
              r'''$.cameras[*]''',
            ) !=
            null) {
          FFAppState().cameras = (getJsonField(
            (_model.resultadoCriarIncident?.jsonBody ?? ''),
            r'''$.cameras[*]''',
            true,
          )!
                  .toList()
                  .map<CameraStruct?>(CameraStruct.maybeFromMap)
                  .toList() as Iterable<CameraStruct?>)
              .withoutNulls
              .toList()
              .cast<CameraStruct>();

          FFAppState().update(() {});
        }
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Erro ao recuperar incidentes'),
              content: Text(getJsonField(
                (_model.resultadoCriarIncident?.jsonBody ?? ''),
                r'''$.message''',
              ).toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Sair'),
                ),
              ],
            );
          },
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: custom_widgets.CustomMapWidget(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                searchRadius: 5.0,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100.0,
                          height: 50.0,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/menu.png',
                                        ).image,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 20.0,
                                  buttonSize: 40.0,
                                  fillColor: FlutterFlowTheme.of(context).info,
                                  icon: Icon(
                                    Icons.settings_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      ConfGeralWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 20.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).info,
                                    icon: FaIcon(
                                      FontAwesomeIcons.bell,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0.91, -0.77),
              child: Builder(
                builder: (context) => FlutterFlowIconButton(
                  borderRadius: 20.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.add_a_photo,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(-1.0, 1.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: CardRegistroCamerasWidget(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.91, -0.64),
              child: Builder(
                builder: (context) => FlutterFlowIconButton(
                  borderRadius: 20.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: FaIcon(
                    FontAwesomeIcons.exclamationTriangle,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(-1.0, 1.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: CardRegistroIncidentesWidget(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.89, -0.52),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  await launchUrl(Uri(
                    scheme: 'tel',
                    path: '190',
                  ));
                },
                child: Icon(
                  Icons.sos_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
