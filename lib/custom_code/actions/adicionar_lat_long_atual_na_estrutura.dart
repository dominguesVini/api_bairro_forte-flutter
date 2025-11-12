// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'index.dart'; // Imports other custom actions

import 'index.dart'; // Imports other custom actions

import 'index.dart'; // Imports other custom actions

import 'package:geolocator/geolocator.dart';
import '../../auth/firebase_auth/auth_util.dart';
import '../../backend/api_requests/api_calls.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<bool> adicionarLatLongAtualNaEstrutura() async {
  try {
    developer.log('Iniciando atualização de localização periódica');

    // Continue mesmo com erro no token, pois podemos atualizar a localização localmente

    // Verificar se o serviço de localização está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      developer.log('Serviço de localização está desabilitado');
      return false;
    }

    // Verificar permissões
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        developer.log('Permissão de localização negada');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      developer.log('Permissão de localização negada permanentemente');
      return false;
    }

    // Obter a posição atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Atualizar o FFAppState com a localização atual
    FFAppState().update(() {
      // Atualizar estrutura de Incident se necessário
      FFAppState().filtros = FiltrosStruct(
          latitude: position.latitude,
          longitude: position.longitude,
          type: FFAppState().Incident.type,
          status: FFAppState().Incident.status);
    });

    // Tentar enviar os dados para o servidor, com várias tentativas se necessário
    bool dadosEnviados = false;
    for (int tentativa = 1; tentativa <= 3 && !dadosEnviados; tentativa++) {
      try {
        developer
            .log('Tentativa $tentativa de enviar localização para o servidor');

        // Verifica se temos o userId disponível
        final userId = FFAppState().userId;
        if (userId <= 0) {
          break;
        }

        final response =
            await ApiBairroForteGroup.atualizarLocalizacaoDoUsuarioCall.call(
          latitude: position.latitude,
          userId: userId,
          longitude: position.longitude,
        );

        if (response.succeeded) {
          developer.log('Localização enviada com sucesso para o servidor');
          dadosEnviados = true;
        } else {
          developer.log(
              'Erro ao enviar localização para o servidor (Código: ${response.statusCode})');

          if (tentativa < 3) {
            // Espera um pouco antes de tentar novamente
            await Future.delayed(Duration(seconds: 2 * tentativa));
          }
        }
      } catch (e) {
        developer.log(
            ' Exceção ao chamar API de atualização de localização (Tentativa $tentativa): $e');

        if (tentativa < 3) {
          // Espera um pouco antes de tentar novamente
          await Future.delayed(Duration(seconds: 3 * tentativa));
        }
      }
    }

    // Se mesmo após as tentativas não conseguiu enviar, salva localmente para enviar depois
    if (!dadosEnviados) {
      _salvarLocalizacaoPendente(position.latitude, position.longitude);
    }

    // Tenta enviar localizações pendentes se houver conexão
    _enviarLocalizacoesPendentes();

    return true;
  } catch (e) {
    developer.log('Erro ao obter localização: $e');
    return false;
  }
}

// Salva localização que não pôde ser enviada para tentar enviar depois
void _salvarLocalizacaoPendente(double latitude, double longitude) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Recupera a lista atual de localizações pendentes
    List<Map<String, dynamic>> localizacoesPendentes = [];
    final String? localizacoesString =
        prefs.getString('localizacoes_pendentes');

    if (localizacoesString != null) {
      final List<dynamic> lista = jsonDecode(localizacoesString);
      localizacoesPendentes = lista.cast<Map<String, dynamic>>();
    }

    // Adiciona a nova localização com timestamp
    localizacoesPendentes.add({
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    // Limita a lista para não ficar muito grande (guarda as 20 mais recentes)
    if (localizacoesPendentes.length > 20) {
      localizacoesPendentes =
          localizacoesPendentes.sublist(localizacoesPendentes.length - 20);
    }

    // Salva de volta nas preferências
    await prefs.setString(
        'localizacoes_pendentes', jsonEncode(localizacoesPendentes));

    developer.log(
        'Localização pendente salva para envio futuro: $latitude, $longitude');
  } catch (e) {
    developer.log('Erro ao salvar localização pendente: $e');
  }
}

// Tenta enviar localizações pendentes quando houver conexão
void _enviarLocalizacoesPendentes() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final String? localizacoesString =
        prefs.getString('localizacoes_pendentes');

    if (localizacoesString == null || localizacoesString.isEmpty) {
      return; // Não há localizações pendentes
    }

    final List<dynamic> lista = jsonDecode(localizacoesString);
    final List<Map<String, dynamic>> localizacoesPendentes =
        lista.cast<Map<String, dynamic>>();

    if (localizacoesPendentes.isEmpty) {
      return;
    }

    developer.log(
        'Tentando enviar ${localizacoesPendentes.length} localizações pendentes');

    // Verifica se temos o userId disponível
    final userId = FFAppState().userId;
    if (userId <= 0) {
      developer
          .log('userId inválido para enviar localizações pendentes: $userId');
      return;
    }

    // Lista para armazenar as localizações que foram enviadas com sucesso
    List<int> indicesEnviados = [];

    // Tenta enviar cada localização pendente
    for (int i = 0; i < localizacoesPendentes.length; i++) {
      final loc = localizacoesPendentes[i];

      try {
        final response =
            await ApiBairroForteGroup.atualizarLocalizacaoDoUsuarioCall.call(
          latitude: loc['latitude'],
          longitude: loc['longitude'],
          userId: userId,
        );

        if (response.succeeded) {
          indicesEnviados.add(i);
          developer.log(
              'Localização pendente enviada com sucesso: ${loc['latitude']}, ${loc['longitude']}');
        }
      } catch (e) {
        developer.log('Erro ao enviar localização pendente: $e');
        // Continua tentando as outras localizações
      }
    }

    // Remove as localizações que foram enviadas com sucesso
    if (indicesEnviados.isNotEmpty) {
      // Remove de trás para frente para não afetar os índices
      indicesEnviados.sort((a, b) => b.compareTo(a));
      for (int indice in indicesEnviados) {
        localizacoesPendentes.removeAt(indice);
      }

      // Salva a lista atualizada
      if (localizacoesPendentes.isEmpty) {
        await prefs.remove('localizacoes_pendentes');
        developer
            .log('Todas as localizações pendentes foram enviadas com sucesso');
      } else {
        await prefs.setString(
            'localizacoes_pendentes', jsonEncode(localizacoesPendentes));
        developer.log(
            '${indicesEnviados.length} localizações pendentes enviadas, ${localizacoesPendentes.length} restantes');
      }
    }
  } catch (e) {
    developer.log('Erro ao processar localizações pendentes: $e');
  }
}
