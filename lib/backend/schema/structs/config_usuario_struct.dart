// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConfigUsuarioStruct extends FFFirebaseStruct {
  ConfigUsuarioStruct({
    double? raio,
    double? latitudeAtual,
    double? longitudeAtual,
    int? userId,
    DateTime? periodoDas,
    DateTime? periodoAte,
    List<String>? categorias,
    bool? apenasGrupos,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _raio = raio,
        _latitudeAtual = latitudeAtual,
        _longitudeAtual = longitudeAtual,
        _userId = userId,
        _periodoDas = periodoDas,
        _periodoAte = periodoAte,
        _categorias = categorias,
        _apenasGrupos = apenasGrupos,
        super(firestoreUtilData);

  // "raio" field.
  double? _raio;
  double get raio => _raio ?? 0.0;
  set raio(double? val) => _raio = val;

  void incrementRaio(double amount) => raio = raio + amount;

  bool hasRaio() => _raio != null;

  // "latitude_atual" field.
  double? _latitudeAtual;
  double get latitudeAtual => _latitudeAtual ?? 0.0;
  set latitudeAtual(double? val) => _latitudeAtual = val;

  void incrementLatitudeAtual(double amount) =>
      latitudeAtual = latitudeAtual + amount;

  bool hasLatitudeAtual() => _latitudeAtual != null;

  // "longitude_atual" field.
  double? _longitudeAtual;
  double get longitudeAtual => _longitudeAtual ?? 0.0;
  set longitudeAtual(double? val) => _longitudeAtual = val;

  void incrementLongitudeAtual(double amount) =>
      longitudeAtual = longitudeAtual + amount;

  bool hasLongitudeAtual() => _longitudeAtual != null;

  // "user_id" field.
  int? _userId;
  int get userId => _userId ?? 0;
  set userId(int? val) => _userId = val;

  void incrementUserId(int amount) => userId = userId + amount;

  bool hasUserId() => _userId != null;

  // "periodo_das" field.
  DateTime? _periodoDas;
  DateTime? get periodoDas => _periodoDas;
  set periodoDas(DateTime? val) => _periodoDas = val;

  bool hasPeriodoDas() => _periodoDas != null;

  // "periodo_ate" field.
  DateTime? _periodoAte;
  DateTime? get periodoAte => _periodoAte;
  set periodoAte(DateTime? val) => _periodoAte = val;

  bool hasPeriodoAte() => _periodoAte != null;

  // "categorias" field.
  List<String>? _categorias;
  List<String> get categorias => _categorias ?? const [];
  set categorias(List<String>? val) => _categorias = val;

  void updateCategorias(Function(List<String>) updateFn) {
    updateFn(_categorias ??= []);
  }

  bool hasCategorias() => _categorias != null;

  // "apenas_grupos" field.
  bool? _apenasGrupos;
  bool get apenasGrupos => _apenasGrupos ?? false;
  set apenasGrupos(bool? val) => _apenasGrupos = val;

  bool hasApenasGrupos() => _apenasGrupos != null;

  static ConfigUsuarioStruct fromMap(Map<String, dynamic> data) =>
      ConfigUsuarioStruct(
        raio: castToType<double>(data['raio']),
        latitudeAtual: castToType<double>(data['latitude_atual']),
        longitudeAtual: castToType<double>(data['longitude_atual']),
        userId: castToType<int>(data['user_id']),
        periodoDas: data['periodo_das'] as DateTime?,
        periodoAte: data['periodo_ate'] as DateTime?,
        categorias: getDataList(data['categorias']),
        apenasGrupos: data['apenas_grupos'] as bool?,
      );

  static ConfigUsuarioStruct? maybeFromMap(dynamic data) => data is Map
      ? ConfigUsuarioStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'raio': _raio,
        'latitude_atual': _latitudeAtual,
        'longitude_atual': _longitudeAtual,
        'user_id': _userId,
        'periodo_das': _periodoDas,
        'periodo_ate': _periodoAte,
        'categorias': _categorias,
        'apenas_grupos': _apenasGrupos,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'raio': serializeParam(
          _raio,
          ParamType.double,
        ),
        'latitude_atual': serializeParam(
          _latitudeAtual,
          ParamType.double,
        ),
        'longitude_atual': serializeParam(
          _longitudeAtual,
          ParamType.double,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.int,
        ),
        'periodo_das': serializeParam(
          _periodoDas,
          ParamType.DateTime,
        ),
        'periodo_ate': serializeParam(
          _periodoAte,
          ParamType.DateTime,
        ),
        'categorias': serializeParam(
          _categorias,
          ParamType.String,
          isList: true,
        ),
        'apenas_grupos': serializeParam(
          _apenasGrupos,
          ParamType.bool,
        ),
      }.withoutNulls;

  static ConfigUsuarioStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConfigUsuarioStruct(
        raio: deserializeParam(
          data['raio'],
          ParamType.double,
          false,
        ),
        latitudeAtual: deserializeParam(
          data['latitude_atual'],
          ParamType.double,
          false,
        ),
        longitudeAtual: deserializeParam(
          data['longitude_atual'],
          ParamType.double,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.int,
          false,
        ),
        periodoDas: deserializeParam(
          data['periodo_das'],
          ParamType.DateTime,
          false,
        ),
        periodoAte: deserializeParam(
          data['periodo_ate'],
          ParamType.DateTime,
          false,
        ),
        categorias: deserializeParam<String>(
          data['categorias'],
          ParamType.String,
          true,
        ),
        apenasGrupos: deserializeParam(
          data['apenas_grupos'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'ConfigUsuarioStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ConfigUsuarioStruct &&
        raio == other.raio &&
        latitudeAtual == other.latitudeAtual &&
        longitudeAtual == other.longitudeAtual &&
        userId == other.userId &&
        periodoDas == other.periodoDas &&
        periodoAte == other.periodoAte &&
        listEquality.equals(categorias, other.categorias) &&
        apenasGrupos == other.apenasGrupos;
  }

  @override
  int get hashCode => const ListEquality().hash([
        raio,
        latitudeAtual,
        longitudeAtual,
        userId,
        periodoDas,
        periodoAte,
        categorias,
        apenasGrupos
      ]);
}

ConfigUsuarioStruct createConfigUsuarioStruct({
  double? raio,
  double? latitudeAtual,
  double? longitudeAtual,
  int? userId,
  DateTime? periodoDas,
  DateTime? periodoAte,
  bool? apenasGrupos,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ConfigUsuarioStruct(
      raio: raio,
      latitudeAtual: latitudeAtual,
      longitudeAtual: longitudeAtual,
      userId: userId,
      periodoDas: periodoDas,
      periodoAte: periodoAte,
      apenasGrupos: apenasGrupos,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ConfigUsuarioStruct? updateConfigUsuarioStruct(
  ConfigUsuarioStruct? configUsuario, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    configUsuario
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addConfigUsuarioStructData(
  Map<String, dynamic> firestoreData,
  ConfigUsuarioStruct? configUsuario,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (configUsuario == null) {
    return;
  }
  if (configUsuario.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && configUsuario.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final configUsuarioData =
      getConfigUsuarioFirestoreData(configUsuario, forFieldValue);
  final nestedData =
      configUsuarioData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = configUsuario.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getConfigUsuarioFirestoreData(
  ConfigUsuarioStruct? configUsuario, [
  bool forFieldValue = false,
]) {
  if (configUsuario == null) {
    return {};
  }
  final firestoreData = mapToFirestore(configUsuario.toMap());

  // Add any Firestore field values
  configUsuario.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getConfigUsuarioListFirestoreData(
  List<ConfigUsuarioStruct>? configUsuarios,
) =>
    configUsuarios
        ?.map((e) => getConfigUsuarioFirestoreData(e, true))
        .toList() ??
    [];
