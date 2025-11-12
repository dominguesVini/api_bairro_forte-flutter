import 'dart:async';

import 'serialization_util.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Color(0x00FFFFFF),
          child: Image.asset(
            'assets/images/screen.png',
            fit: BoxFit.cover,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'mapaDinamico': ParameterData.none(),
  'Login': ParameterData.none(),
  'createAccount_01': ParameterData.none(),
  'createAccount_02': ParameterData.none(),
  'createAccount_03': ParameterData.none(),
  'createAccount_04': ParameterData.none(),
  'createAccount_05': ParameterData.none(),
  'createAccount_06': ParameterData.none(),
  'createAccount_07': (data) async => ParameterData(
        allParams: {
          'phoneNumber': getParameter<String>(data, 'phoneNumber'),
        },
      ),
  'perfil': ParameterData.none(),
  'cameras': ParameterData.none(),
  'add_camera': ParameterData.none(),
  'edit_camera': (data) async => ParameterData(
        allParams: {
          'description': getParameter<String>(data, 'description'),
          'isPrivado': getParameter<bool>(data, 'isPrivado'),
          'id': getParameter<int>(data, 'id'),
        },
      ),
  'notifications': ParameterData.none(),
  'groups': ParameterData.none(),
  'preferences_configuration': (data) async => ParameterData(
        allParams: {
          'isCadastro': getParameter<bool>(data, 'isCadastro'),
        },
      ),
  'conf_geral': ParameterData.none(),
  'rotas': ParameterData.none(),
  'cadastrar_rotas': ParameterData.none(),
  'detalhes_rotas': ParameterData.none(),
  'meus_usuarios': ParameterData.none(),
  'dados_usuarios': ParameterData.none(),
  'conf_privacidade': ParameterData.none(),
  'detalhes_grupo': (data) async => ParameterData(
        allParams: {
          'groupId': getParameter<int>(data, 'groupId'),
          'isDono': getParameter<bool>(data, 'isDono'),
        },
      ),
  'relatorios': ParameterData.none(),
  'tela_relatorio': ParameterData.none(),
  'faq_duvidas': ParameterData.none(),
  'detalhes_rota': ParameterData.none(),
  'criar_grupo': ParameterData.none(),
  'dados_usuario': ParameterData.none(),
  'notificatios': ParameterData.none(),
  'mudar_senha': ParameterData.none(),
  'incidentes': ParameterData.none(),
  'detalhes_incidente': (data) async => ParameterData(
        allParams: {
          'incidentId': getParameter<int>(data, 'incidentId'),
        },
      ),
  'entrar_em_um_grupo': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
