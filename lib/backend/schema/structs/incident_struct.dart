// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class IncidentStruct extends FFFirebaseStruct {
  IncidentStruct({
    String? type,
    String? description,
    double? latitude,
    double? longitude,
    String? status,
    String? user,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _description = description,
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

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  set user(String? val) => _user = val;

  bool hasUser() => _user != null;

  static IncidentStruct fromMap(Map<String, dynamic> data) => IncidentStruct(
        type: data['type'] as String?,
        description: data['description'] as String?,
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        status: data['status'] as String?,
        user: data['user'] as String?,
      );

  static IncidentStruct? maybeFromMap(dynamic data) =>
      data is Map ? IncidentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'description': _description,
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
        'user': serializeParam(
          _user,
          ParamType.String,
        ),
      }.withoutNulls;

  static IncidentStruct fromSerializableMap(Map<String, dynamic> data) =>
      IncidentStruct(
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
        user: deserializeParam(
          data['user'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'IncidentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IncidentStruct &&
        type == other.type &&
        description == other.description &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        status == other.status &&
        user == other.user;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([type, description, latitude, longitude, status, user]);
}

IncidentStruct createIncidentStruct({
  String? type,
  String? description,
  double? latitude,
  double? longitude,
  String? status,
  String? user,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IncidentStruct(
      type: type,
      description: description,
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

IncidentStruct? updateIncidentStruct(
  IncidentStruct? incident, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    incident
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIncidentStructData(
  Map<String, dynamic> firestoreData,
  IncidentStruct? incident,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (incident == null) {
    return;
  }
  if (incident.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && incident.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final incidentData = getIncidentFirestoreData(incident, forFieldValue);
  final nestedData = incidentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = incident.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIncidentFirestoreData(
  IncidentStruct? incident, [
  bool forFieldValue = false,
]) {
  if (incident == null) {
    return {};
  }
  final firestoreData = mapToFirestore(incident.toMap());

  // Add any Firestore field values
  incident.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIncidentListFirestoreData(
  List<IncidentStruct>? incidents,
) =>
    incidents?.map((e) => getIncidentFirestoreData(e, true)).toList() ?? [];
