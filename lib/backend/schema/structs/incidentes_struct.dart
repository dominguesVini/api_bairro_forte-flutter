// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class IncidentesStruct extends FFFirebaseStruct {
  IncidentesStruct({
    String? type,
    String? description,
    double? latitude,
    double? longitude,
    String? status,
    int? incidentId,
    String? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _description = description,
        _latitude = latitude,
        _longitude = longitude,
        _status = status,
        _incidentId = incidentId,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

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

  // "incident_id" field.
  int? _incidentId;
  int get incidentId => _incidentId ?? 0;
  set incidentId(int? val) => _incidentId = val;

  void incrementIncidentId(int amount) => incidentId = incidentId + amount;

  bool hasIncidentId() => _incidentId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static IncidentesStruct fromMap(Map<String, dynamic> data) =>
      IncidentesStruct(
        type: data['type'] as String?,
        description: data['description'] as String?,
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        status: data['status'] as String?,
        incidentId: castToType<int>(data['incident_id']),
        createdAt: data['created_at'] as String?,
      );

  static IncidentesStruct? maybeFromMap(dynamic data) => data is Map
      ? IncidentesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'description': _description,
        'latitude': _latitude,
        'longitude': _longitude,
        'status': _status,
        'incident_id': _incidentId,
        'created_at': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
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
        'incident_id': serializeParam(
          _incidentId,
          ParamType.int,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static IncidentesStruct fromSerializableMap(Map<String, dynamic> data) =>
      IncidentesStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
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
        incidentId: deserializeParam(
          data['incident_id'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'IncidentesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IncidentesStruct &&
        type == other.type &&
        description == other.description &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        status == other.status &&
        incidentId == other.incidentId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [type, description, latitude, longitude, status, incidentId, createdAt]);
}

IncidentesStruct createIncidentesStruct({
  String? type,
  String? description,
  double? latitude,
  double? longitude,
  String? status,
  int? incidentId,
  String? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IncidentesStruct(
      type: type,
      description: description,
      latitude: latitude,
      longitude: longitude,
      status: status,
      incidentId: incidentId,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

IncidentesStruct? updateIncidentesStruct(
  IncidentesStruct? incidentes, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    incidentes
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIncidentesStructData(
  Map<String, dynamic> firestoreData,
  IncidentesStruct? incidentes,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (incidentes == null) {
    return;
  }
  if (incidentes.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && incidentes.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final incidentesData = getIncidentesFirestoreData(incidentes, forFieldValue);
  final nestedData = incidentesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = incidentes.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIncidentesFirestoreData(
  IncidentesStruct? incidentes, [
  bool forFieldValue = false,
]) {
  if (incidentes == null) {
    return {};
  }
  final firestoreData = mapToFirestore(incidentes.toMap());

  // Add any Firestore field values
  incidentes.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIncidentesListFirestoreData(
  List<IncidentesStruct>? incidentess,
) =>
    incidentess?.map((e) => getIncidentesFirestoreData(e, true)).toList() ?? [];
