// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FiltrosStruct extends FFFirebaseStruct {
  FiltrosStruct({
    String? type,
    int? raio,
    double? latitude,
    double? longitude,
    String? status,
    String? user,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _raio = raio,
        _latitude = latitude,
        _longitude = longitude,
        _status = status,
        _user = user,
        super(firestoreUtilData);

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "raio" field.
  int? _raio;
  int get raio => _raio ?? 0;
  set raio(int? val) => _raio = val;

  void incrementRaio(int amount) => raio = raio + amount;

  bool hasRaio() => _raio != null;

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  set latitude(double? val) => _latitude = val;

  void incrementLatitude(double amount) => latitude = latitude + amount;

  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  set longitude(double? val) => _longitude = val;

  void incrementLongitude(double amount) => longitude = longitude + amount;

  bool hasLongitude() => _longitude != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  set user(String? val) => _user = val;

  bool hasUser() => _user != null;

  static FiltrosStruct fromMap(Map<String, dynamic> data) => FiltrosStruct(
        type: data['type'] as String?,
        raio: castToType<int>(data['raio']),
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        status: data['status'] as String?,
        user: data['user'] as String?,
      );

  static FiltrosStruct? maybeFromMap(dynamic data) =>
      data is Map ? FiltrosStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'raio': _raio,
        'latitude': _latitude,
        'longitude': _longitude,
        'status': _status,
        'user': _user,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'raio': serializeParam(
          _raio,
          ParamType.int,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'user': serializeParam(
          _user,
          ParamType.String,
        ),
      }.withoutNulls;

  static FiltrosStruct fromSerializableMap(Map<String, dynamic> data) =>
      FiltrosStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        raio: deserializeParam(
          data['raio'],
          ParamType.int,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.double,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.double,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        user: deserializeParam(
          data['user'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FiltrosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FiltrosStruct &&
        type == other.type &&
        raio == other.raio &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        status == other.status &&
        user == other.user;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([type, raio, latitude, longitude, status, user]);
}

FiltrosStruct createFiltrosStruct({
  String? type,
  int? raio,
  double? latitude,
  double? longitude,
  String? status,
  String? user,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FiltrosStruct(
      type: type,
      raio: raio,
      latitude: latitude,
      longitude: longitude,
      status: status,
      user: user,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FiltrosStruct? updateFiltrosStruct(
  FiltrosStruct? filtros, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    filtros
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFiltrosStructData(
  Map<String, dynamic> firestoreData,
  FiltrosStruct? filtros,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (filtros == null) {
    return;
  }
  if (filtros.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && filtros.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final filtrosData = getFiltrosFirestoreData(filtros, forFieldValue);
  final nestedData = filtrosData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = filtros.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFiltrosFirestoreData(
  FiltrosStruct? filtros, [
  bool forFieldValue = false,
]) {
  if (filtros == null) {
    return {};
  }
  final firestoreData = mapToFirestore(filtros.toMap());

  // Add any Firestore field values
  filtros.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFiltrosListFirestoreData(
  List<FiltrosStruct>? filtross,
) =>
    filtross?.map((e) => getFiltrosFirestoreData(e, true)).toList() ?? [];
