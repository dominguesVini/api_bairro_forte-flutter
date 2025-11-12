import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start ApiBairroForte Group Code

class ApiBairroForteGroup {
  static String getBaseUrl({
    String? token = '',
  }) =>
      'https://api-bairro-forte-dev.ezdmazbdgzg4d5bb.westus2.azurecontainer.io';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [token]',
  };
  static NewIncidentCall newIncidentCall = NewIncidentCall();
  static GetIncidentCall getIncidentCall = GetIncidentCall();
  static GetCamerasCall getCamerasCall = GetCamerasCall();
  static NewCameraCall newCameraCall = NewCameraCall();
  static GetRegistrosCall getRegistrosCall = GetRegistrosCall();
  static SaveprefrencesCall saveprefrencesCall = SaveprefrencesCall();
  static GetPreferenceUserCall getPreferenceUserCall = GetPreferenceUserCall();
  static CriarUsuarioCall criarUsuarioCall = CriarUsuarioCall();
  static GetCamerasUserCall getCamerasUserCall = GetCamerasUserCall();
  static EditCameraCall editCameraCall = EditCameraCall();
  static GetReltorioCall getReltorioCall = GetReltorioCall();
  static CriarGruposComUsuariosCall criarGruposComUsuariosCall =
      CriarGruposComUsuariosCall();
  static MeusGruposCall meusGruposCall = MeusGruposCall();
  static PegarInfosDeUmGrupoCall pegarInfosDeUmGrupoCall =
      PegarInfosDeUmGrupoCall();
  static AtualizarGrupoCall atualizarGrupoCall = AtualizarGrupoCall();
  static AlterarPrivacidadeCall alterarPrivacidadeCall =
      AlterarPrivacidadeCall();
  static AtualizarUsuarioCall atualizarUsuarioCall = AtualizarUsuarioCall();
  static MeusDadosCall meusDadosCall = MeusDadosCall();
  static NotificacoesDoUsuarioCall notificacoesDoUsuarioCall =
      NotificacoesDoUsuarioCall();
  static SairDoGrupoCall sairDoGrupoCall = SairDoGrupoCall();
  static AtualizarLocalizaoCall atualizarLocalizaoCall =
      AtualizarLocalizaoCall();
  static MeusIncidentesCall meusIncidentesCall = MeusIncidentesCall();
  static CancelarIncidenteCall cancelarIncidenteCall = CancelarIncidenteCall();
  static PegarInfosDeUmIncidenteCall pegarInfosDeUmIncidenteCall =
      PegarInfosDeUmIncidenteCall();
  static DeletarIncidenteCall deletarIncidenteCall = DeletarIncidenteCall();
  static AtualizarLocalizacaoDoUsuarioCall atualizarLocalizacaoDoUsuarioCall =
      AtualizarLocalizacaoDoUsuarioCall();
  static DeletarCameraCall deletarCameraCall = DeletarCameraCall();
  static EnviarReportDeFalhaCall enviarReportDeFalhaCall =
      EnviarReportDeFalhaCall();
  static GruposQuePossoEntrarCall gruposQuePossoEntrarCall =
      GruposQuePossoEntrarCall();
  static EntrarEmUmFGrupoCall entrarEmUmFGrupoCall = EntrarEmUmFGrupoCall();
}

class NewIncidentCall {
  Future<ApiCallResponse> call({
    double? latitude,
    double? longitude,
    String? type = '',
    int? userId,
    String? description = '',
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "latitude": ${latitude},
  "longitude": ${longitude},
  "type": "${escapeStringForJson(type)}",
  "description": "${escapeStringForJson(description)}",
  "user_id":${userId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'newIncident',
      apiUrl: '${baseUrl}/incidents',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.statusCode''',
      ));
}

class GetIncidentCall {
  Future<ApiCallResponse> call({
    List<String>? typeList,
    double? raio,
    double? longitude,
    double? latitude,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );
    final type = _serializeList(typeList);

    return ApiManager.instance.makeApiCall(
      callName: 'getIncident',
      apiUrl: '${baseUrl}/incidents',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'latitude': latitude,
        'longitude': longitude,
        'raio': raio,
        'type': type,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? incidents(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
        true,
      ) as List?;
}

class GetCamerasCall {
  Future<ApiCallResponse> call({
    double? localizacao,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getCameras',
      apiUrl: '${baseUrl}/cameras',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'localizacao': localizacao,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class NewCameraCall {
  Future<ApiCallResponse> call({
    String? description = '',
    double? latitude,
    double? longitude,
    bool? shared = true,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "description": "${escapeStringForJson(description)}",
  "latitude": ${latitude},
  "longitude": ${longitude},
  "shared": ${shared}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'newCamera',
      apiUrl: '${baseUrl}/cameras',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetRegistrosCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getRegistros',
      apiUrl: '${baseUrl}/registros',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SaveprefrencesCall {
  Future<ApiCallResponse> call({
    int? userId,
    double? radiusKm,
    List<String>? categoryList,
    String? periodStart = '',
    String? periodEnd = '',
    bool? groupOnly,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );
    final category = _serializeList(categoryList);

    final ffApiRequestBody = '''
{
  "user_id": ${userId},
  "radius_km": ${radiusKm},
  "category": ${category},
  "period_start": "${escapeStringForJson(periodStart)}",
  "period_end": "${escapeStringForJson(periodEnd)}",
  "group_only": ${groupOnly}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Saveprefrences',
      apiUrl: '${baseUrl}/user-settings',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetPreferenceUserCall {
  Future<ApiCallResponse> call({
    int? userId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getPreferenceUser',
      apiUrl: '${baseUrl}/user-settings/user',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CriarUsuarioCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? role = '',
    String? gender = '',
    double? latitude,
    double? longitude,
    String? phone = '',
    int? cityId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}",
  "role": "${escapeStringForJson(role)}",
  "gender": "${escapeStringForJson(gender)}",
  "latitude": ${latitude},
  "longitude": ${longitude},
  "phone": "${escapeStringForJson(phone)}",
  "city_id": ${cityId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'criarUsuario',
      apiUrl: '${baseUrl}/users',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCamerasUserCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getCamerasUser',
      apiUrl: '${baseUrl}/cameras/me',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EditCameraCall {
  Future<ApiCallResponse> call({
    int? cameraId,
    bool? cameraShared,
    String? cameraDescription = '',
    double? latitude,
    double? longitude,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "camera_shared": ${cameraShared},
  "camera_description": "${escapeStringForJson(cameraDescription)}",
  "latitude": ${latitude},
  "longitude": ${longitude}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'editCamera',
      apiUrl: '${baseUrl}/cameras/${cameraId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetReltorioCall {
  Future<ApiCallResponse> call({
    String? start = '',
    String? end = '',
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getReltorio',
      apiUrl: '${baseUrl}/incidents/report',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'start': start,
        'end': end,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CriarGruposComUsuariosCall {
  Future<ApiCallResponse> call({
    String? name = '',
    bool? private,
    List<String>? phonesList,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );
    final phones = _serializeList(phonesList);

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "private": ${private},
  "phones": ${phones}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'criarGruposComUsuarios',
      apiUrl: '${baseUrl}/groups/with-users',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MeusGruposCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'meusGrupos',
      apiUrl: '${baseUrl}/groups/me',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PegarInfosDeUmGrupoCall {
  Future<ApiCallResponse> call({
    int? groupId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'pegarInfosDeUmGrupo',
      apiUrl: '${baseUrl}/groups/${groupId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AtualizarGrupoCall {
  Future<ApiCallResponse> call({
    bool? private,
    String? name = '',
    List<String>? addPhonesList,
    List<int>? groupIdList,
    List<int>? removeList,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );
    final addPhones = _serializeList(addPhonesList);
    final groupId = _serializeList(groupIdList);
    final remove = _serializeList(removeList);

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "private": ${private},
  "users": {
    "add_phones": ${addPhones},
    "remove": ${remove}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'atualizarGrupo',
      apiUrl: '${baseUrl}/groups/${groupId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AlterarPrivacidadeCall {
  Future<ApiCallResponse> call({
    bool? shareReportedInfo,
    bool? showInfoInGroups,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "share_reported_info": ${shareReportedInfo},
  "show_info_in_groups": ${showInfoInGroups}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'alterarPrivacidade',
      apiUrl: '${baseUrl}/users/me/privacy',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AtualizarUsuarioCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? gender = '',
    double? latitude,
    double? longitude,
    String? phone = '',
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "gender": "${escapeStringForJson(gender)}",
  "latitude": ${latitude},
  "longitude": ${longitude},
  "phone": "${escapeStringForJson(phone)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'atualizarUsuario',
      apiUrl: '${baseUrl}/users/me/profile',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MeusDadosCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'meusDados',
      apiUrl: '${baseUrl}/users/me/profile',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class NotificacoesDoUsuarioCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'notificacoesDoUsuario',
      apiUrl: '${baseUrl}/notifications',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SairDoGrupoCall {
  Future<ApiCallResponse> call({
    int? groupId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "group_id": ${groupId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sairDoGrupo',
      apiUrl: '${baseUrl}/groups/leave',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AtualizarLocalizaoCall {
  Future<ApiCallResponse> call({
    double? latitude,
    double? longitude,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "latitude": ${latitude},
  "longitude": ${longitude}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'atualizarLocalizao',
      apiUrl: '${baseUrl}/users/me/location',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MeusIncidentesCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'meusIncidentes',
      apiUrl: '${baseUrl}/incidents/me',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CancelarIncidenteCall {
  Future<ApiCallResponse> call({
    int? incidenteId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "id_incidente": ${incidenteId}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'cancelarIncidente',
      apiUrl: '${baseUrl}/incidentes/cancelar',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PegarInfosDeUmIncidenteCall {
  Future<ApiCallResponse> call({
    int? idIncidente,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'pegarInfosDeUmIncidente',
      apiUrl: '${baseUrl}/incidents/${idIncidente}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletarIncidenteCall {
  Future<ApiCallResponse> call({
    int? incidentId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'deletarIncidente',
      apiUrl: '${baseUrl}/incidents/${incidentId}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AtualizarLocalizacaoDoUsuarioCall {
  Future<ApiCallResponse> call({
    double? longitude,
    double? latitude,
    int? userId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "userId": ${userId},
  "latitude": ${latitude},
  "longitude": ${longitude}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'atualizarLocalizacaoDoUsuario',
      apiUrl: '${baseUrl}/users/location/update',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'X-API-Key': 'bairro-forte-location-api-key-c8d871efc2d4b96a7537',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeletarCameraCall {
  Future<ApiCallResponse> call({
    int? idCamera,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'deletarCamera',
      apiUrl: '${baseUrl}/cameras/${idCamera}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EnviarReportDeFalhaCall {
  Future<ApiCallResponse> call({
    String? message = '',
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    final ffApiRequestBody = '''
{
  "message": "${escapeStringForJson(message)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'enviarReportDeFalha',
      apiUrl: '${baseUrl}/reports/app-failure',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GruposQuePossoEntrarCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'gruposQuePossoEntrar',
      apiUrl: '${baseUrl}/groups/available',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EntrarEmUmFGrupoCall {
  Future<ApiCallResponse> call({
    int? groupId,
    String? token = '',
  }) async {
    final baseUrl = ApiBairroForteGroup.getBaseUrl(
      token: token,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'entrarEmUmFGrupo',
      apiUrl: '${baseUrl}/groups/${groupId}/join',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End ApiBairroForte Group Code

/// Start GroupsApiBairroForte Group Code

class GroupsApiBairroForteGroup {
  static String getBaseUrl() =>
      'https://api-bairro-forte-dev.ezdmazbdgzg4d5bb.westus2.azurecontainer.io';
  static Map<String, String> headers = {};
  static GetGroupsUserCall getGroupsUserCall = GetGroupsUserCall();
}

class GetGroupsUserCall {
  Future<ApiCallResponse> call({
    int? userId,
  }) async {
    final baseUrl = GroupsApiBairroForteGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'getGroupsUser',
      apiUrl: '${baseUrl}/groups/user/${userId}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic grupos(dynamic response) => getJsonField(
        response,
        r'''$[*]''',
      );
}

/// End GroupsApiBairroForte Group Code

class SendSMSTwilioCall {
  static Future<ApiCallResponse> call({
    String? to = '',
    String? from = '+17754687555',
    String? body = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'sendSMSTwilio',
      apiUrl:
          'https://api.twilio.com/2010-04-01/Accounts/<account_sid>/Messages.json',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic <twilio token>',
      },
      params: {
        'To': to,
        'Body': body,
        'From': from,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VerificarCodigoTwilioCall {
  static Future<ApiCallResponse> call({
    String? to = '',
    String? code = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'verificarCodigoTwilio',
      apiUrl:
          'https://verify.twilio.com/v2/Services/<service_sid>/VerificationCheck',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic <twilio token>',
      },
      params: {
        'To': to,
        'Code': code,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static bool? valido(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.valid''',
      ));
  static String? aprovado(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class EnviarCodigoVerificacaoCall {
  static Future<ApiCallResponse> call({
    String? to = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'enviarCodigoVerificacao',
      apiUrl:
          'https://verify.twilio.com/v2/Services/<service_sid>/Verifications',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Basic <twilio token>',
      },
      params: {
        'To': to,
        'Channel': "sms",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MunicipiosIbgeCall {
  static Future<ApiCallResponse> call({
    String? uf = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'municipiosIbge',
      apiUrl:
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf}/municipios',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? nome(dynamic response) => (getJsonField(
        response,
        r'''$[:].nome''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? ids(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class UFsIbgeCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'UFsIbge',
      apiUrl: 'https://servicodados.ibge.gov.br/api/v1/localidades/estados',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? uf(dynamic response) => (getJsonField(
        response,
        r'''$[:].sigla''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? nome(dynamic response) => (getJsonField(
        response,
        r'''$[:].nome''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? ids(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
