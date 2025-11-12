import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_account07_model.dart';
export 'create_account07_model.dart';

class CreateAccount07Widget extends StatefulWidget {
  const CreateAccount07Widget({
    super.key,
    this.phoneNumber,
  });

  final String? phoneNumber;

  static String routeName = 'createAccount_07';
  static String routePath = '/createAccount07';

  @override
  State<CreateAccount07Widget> createState() => _CreateAccount07WidgetState();
}

class _CreateAccount07WidgetState extends State<CreateAccount07Widget> {
  late CreateAccount07Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccount07Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await authManager.sendEmailVerification();
    });

    _model.pinCodeFocusNode ??= FocusNode();

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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/playstore.png',
                      width: 300.0,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Criar uma conta',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: Color(0xFF36454F),
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.mail_outline,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.person_3_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.transgenderAlt,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Icon(
                          Icons.key_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.phone_iphone_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 30.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                        ),
                      ),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).corPrimaria,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.check_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Digite o código de 6 dígitos enviado a',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.phoneNumber,
                                '** * ****-****',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: PinCodeTextField(
                          autoDisposeControllers: false,
                          appContext: context,
                          length: 6,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          enableActiveFill: false,
                          autoFocus: true,
                          focusNode: _model.pinCodeFocusNode,
                          enablePinAutofill: false,
                          errorTextSpace: 16.0,
                          showCursor: true,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          obscureText: false,
                          hintCharacter: '●',
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            fieldHeight: 44.0,
                            fieldWidth: 44.0,
                            borderWidth: 2.0,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0),
                              bottomRight: Radius.circular(12.0),
                              topLeft: Radius.circular(12.0),
                              topRight: Radius.circular(12.0),
                            ),
                            shape: PinCodeFieldShape.box,
                            activeColor:
                                FlutterFlowTheme.of(context).primaryText,
                            inactiveColor:
                                FlutterFlowTheme.of(context).alternate,
                            selectedColor: FlutterFlowTheme.of(context).primary,
                          ),
                          controller: _model.pinCodeController,
                          onChanged: (_) {},
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _model.pinCodeControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await authManager.refreshUser();
                            if (FFAppState().emailSendVerification) {
                              if (currentUserEmailVerified) {
                                await actions
                                    .adicionarLatLongAtualNaEstrutura();
                                _model.resultadoCriarUsuario3 =
                                    await ApiBairroForteGroup.criarUsuarioCall
                                        .call(
                                  name: FFAppState().name,
                                  email: FFAppState().Email,
                                  role: 'Morador',
                                  gender: FFAppState().sexo,
                                  latitude: FFAppState().filtros.latitude,
                                  longitude: FFAppState().filtros.longitude,
                                  phone: widget.phoneNumber,
                                  cityId: FFAppState().idCidade,
                                );

                                if ((_model.resultadoCriarUsuario3?.succeeded ??
                                    true)) {
                                  FFAppState().configUsuario =
                                      ConfigUsuarioStruct(
                                    latitudeAtual: getJsonField(
                                      (_model.resultadoCriarUsuario3
                                              ?.jsonBody ??
                                          ''),
                                      r'''$.user.latitude''',
                                    ),
                                    longitudeAtual: getJsonField(
                                      (_model.resultadoCriarUsuario3
                                              ?.jsonBody ??
                                          ''),
                                      r'''$.user.longitude''',
                                    ),
                                    userId: getJsonField(
                                      (_model.resultadoCriarUsuario3
                                              ?.jsonBody ??
                                          ''),
                                      r'''$.user.user_id''',
                                    ),
                                    apenasGrupos: getJsonField(
                                      (_model.resultadoCriarUsuario3
                                              ?.jsonBody ??
                                          ''),
                                      r'''$.user.show_info_in_groups''',
                                    ),
                                  );
                                  FFAppState().userId = getJsonField(
                                    (_model.resultadoCriarUsuario3?.jsonBody ??
                                        ''),
                                    r'''$.user.user_id''',
                                  );
                                  FFAppState().emailSendVerification =
                                      !(FFAppState().emailSendVerification ??
                                          true);
                                  safeSetState(() {});
                                  await actions.onesignal(
                                    FFAppState().Email,
                                  );
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title:
                                            Text('Conta criada com sucesso!'),
                                        content: Text(
                                            'Agora vamos personalizar suas notificações'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ir'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  context.goNamedAuth(
                                    PreferencesConfigurationWidget.routeName,
                                    context.mounted,
                                    queryParameters: {
                                      'isCadastro': serializeParam(
                                        true,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.leftToRight,
                                      ),
                                    },
                                  );
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text(
                                            'Erro ao tentar criar sua conta'),
                                        content:
                                            Text('Tente novamente mais tarde!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Sair'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Favor verificar seu e-mail de cadastro!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (!confirmDialogResponse) {
                                  await authManager.deleteUser(context);

                                  context.pushNamedAuth(
                                      LoginWidget.routeName, context.mounted);
                                }
                              }
                            } else {
                              _model.resultadoVerificarCodigo =
                                  await VerificarCodigoTwilioCall.call(
                                to: '+55${widget.phoneNumber}',
                                code: _model.pinCodeController!.text,
                              );

                              if (VerificarCodigoTwilioCall.valido(
                                (_model.resultadoVerificarCodigo?.jsonBody ??
                                    ''),
                              )!) {
                                GoRouter.of(context).prepareAuthEvent();
                                if (FFAppState().password !=
                                    FFAppState().confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Passwords don\'t match!',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final user =
                                    await authManager.createAccountWithEmail(
                                  context,
                                  FFAppState().Email,
                                  FFAppState().password,
                                );
                                if (user == null) {
                                  return;
                                }

                                await UsersRecord.collection
                                    .doc(user.uid)
                                    .update(createUsersRecordData(
                                      email: FFAppState().Email,
                                      displayName: FFAppState().name,
                                      role: 'Morador',
                                      birthdate: FFAppState().dataRegistroApi,
                                      phoneNumber: FFAppState().telefone,
                                      sex: FFAppState().sexo,
                                    ));

                                if (currentUserEmailVerified) {
                                  await actions
                                      .adicionarLatLongAtualNaEstrutura();
                                  _model.resultadoCriarUsuario =
                                      await ApiBairroForteGroup.criarUsuarioCall
                                          .call(
                                    name: FFAppState().name,
                                    email: FFAppState().Email,
                                    role: 'Morador',
                                    gender: FFAppState().sexo,
                                    latitude: FFAppState().filtros.latitude,
                                    longitude: FFAppState().filtros.longitude,
                                    phone: widget.phoneNumber,
                                    cityId: FFAppState().idCidade,
                                  );

                                  if ((_model
                                          .resultadoCriarUsuario?.succeeded ??
                                      true)) {
                                    FFAppState().configUsuario =
                                        ConfigUsuarioStruct(
                                      latitudeAtual: getJsonField(
                                        (_model.resultadoCriarUsuario
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.user.latitude''',
                                      ),
                                      longitudeAtual: getJsonField(
                                        (_model.resultadoCriarUsuario
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.user.longitude''',
                                      ),
                                      userId: getJsonField(
                                        (_model.resultadoCriarUsuario
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.user.user_id''',
                                      ),
                                      apenasGrupos: getJsonField(
                                        (_model.resultadoCriarUsuario
                                                ?.jsonBody ??
                                            ''),
                                        r'''$.user.show_info_in_groups''',
                                      ),
                                    );
                                    FFAppState().userId = getJsonField(
                                      (_model.resultadoCriarUsuario?.jsonBody ??
                                          ''),
                                      r'''$.user.user_id''',
                                    );
                                    safeSetState(() {});
                                    await actions.onesignal(
                                      FFAppState().Email,
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title:
                                              Text('Conta criada com sucesso!'),
                                          content: Text(
                                              'Agora vamos personalizar suas notificações'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ir'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    context.goNamedAuth(
                                      PreferencesConfigurationWidget.routeName,
                                      context.mounted,
                                      queryParameters: {
                                        'isCadastro': serializeParam(
                                          true,
                                          ParamType.bool,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.leftToRight,
                                        ),
                                      },
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text(
                                              'Erro ao tentar criar sua conta'),
                                          content: Text(
                                              'Tente novamente mais tarde!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Sair'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  await authManager.sendEmailVerification();
                                  FFAppState().emailSendVerification =
                                      !(FFAppState().emailSendVerification ??
                                          true);
                                  safeSetState(() {});
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Favor verificar seu e-mail de cadastro!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: Text('Ok'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                  if (confirmDialogResponse) {}
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Opss'),
                                      content: Text(
                                          'Código inválido, tente novamente!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }

                            safeSetState(() {});
                          },
                          text:
                              '${FFAppState().emailSendVerification ? 'Verificar e-mail' : 'Confirmar'}',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 44.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).corPrimaria,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.montserrat(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
