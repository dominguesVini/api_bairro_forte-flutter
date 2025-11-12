// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class CameraStruct extends FFFirebaseStruct {
  CameraStruct({
    String? description,
    bool? shared,
    double? latitude,
    double? longitude,
    String? createdAt,
    int? cameraId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _description = description,
        _shared = shared,
        _latitude = latitude,
        _longitude = longitude,
        _createdAt = createdAt,
        _cameraId = cameraId,
        super(firestoreUtilData);

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "shared" field.
  bool? _shared;
  bool get shared => _shared ?? false;
  set shared(bool? val) => _shared = val;

  bool hasShared() => _shared != null;

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

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "camera_id" field.
  int? _cameraId;
  int get cameraId => _cameraId ?? 0;
  set cameraId(int? val) => _cameraId = val;

  void incrementCameraId(int amount) => cameraId = cameraId + amount;

  bool hasCameraId() => _cameraId != null;

  static CameraStruct fromMap(Map<String, dynamic> data) => CameraStruct(
        description: data['description'] as String?,
        shared: data['shared'] as bool?,
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
        createdAt: data['created_at'] as String?,
        cameraId: castToType<int>(data['camera_id']),
      );

  static CameraStruct? maybeFromMap(dynamic data) =>
      data is Map ? CameraStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'description': _description,
        'shared': _shared,
        'latitude': _latitude,
        'longitude': _longitude,
        'created_at': _createdAt,
        'camera_id': _cameraId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'shared': serializeParam(
          _shared,
          ParamType.bool,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'camera_id': serializeParam(
          _cameraId,
          ParamType.int,
        ),
      }.withoutNulls;

  static CameraStruct fromSerializableMap(Map<String, dynamic> data) =>
      CameraStruct(
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        shared: deserializeParam(
          data['shared'],
          ParamType.bool,
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
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        cameraId: deserializeParam(
          data['camera_id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CameraStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CameraStruct &&
        description == other.description &&
        shared == other.shared &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        createdAt == other.createdAt &&
        cameraId == other.cameraId;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([description, shared, latitude, longitude, createdAt, cameraId]);
}

CameraStruct createCameraStruct({
  String? description,
  bool? shared,
  double? latitude,
  double? longitude,
  String? createdAt,
  int? cameraId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CameraStruct(
      description: description,
      shared: shared,
      latitude: latitude,
      longitude: longitude,
      createdAt: createdAt,
      cameraId: cameraId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CameraStruct? updateCameraStruct(
  CameraStruct? camera, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    camera
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCameraStructData(
  Map<String, dynamic> firestoreData,
  CameraStruct? camera,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (camera == null) {
    return;
  }
  if (camera.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && camera.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cameraData = getCameraFirestoreData(camera, forFieldValue);
  final nestedData = cameraData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = camera.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCameraFirestoreData(
  CameraStruct? camera, [
  bool forFieldValue = false,
]) {
  if (camera == null) {
    return {};
  }
  final firestoreData = mapToFirestore(camera.toMap());

  // Add any Firestore field values
  camera.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCameraListFirestoreData(
  List<CameraStruct>? cameras,
) =>
    cameras?.map((e) => getCameraFirestoreData(e, true)).toList() ?? [];
