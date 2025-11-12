// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CriarGrupoStruct extends FFFirebaseStruct {
  CriarGrupoStruct({
    String? name,
    bool? private,
    List<String>? phones,
    List<int>? delete,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _private = private,
        _phones = phones,
        _delete = delete,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "private" field.
  bool? _private;
  bool get private => _private ?? false;
  set private(bool? val) => _private = val;

  bool hasPrivate() => _private != null;

  // "phones" field.
  List<String>? _phones;
  List<String> get phones => _phones ?? const [];
  set phones(List<String>? val) => _phones = val;

  void updatePhones(Function(List<String>) updateFn) {
    updateFn(_phones ??= []);
  }

  bool hasPhones() => _phones != null;

  // "delete" field.
  List<int>? _delete;
  List<int> get delete => _delete ?? const [];
  set delete(List<int>? val) => _delete = val;

  void updateDelete(Function(List<int>) updateFn) {
    updateFn(_delete ??= []);
  }

  bool hasDelete() => _delete != null;

  static CriarGrupoStruct fromMap(Map<String, dynamic> data) =>
      CriarGrupoStruct(
        name: data['name'] as String?,
        private: data['private'] as bool?,
        phones: getDataList(data['phones']),
        delete: getDataList(data['delete']),
      );

  static CriarGrupoStruct? maybeFromMap(dynamic data) => data is Map
      ? CriarGrupoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'private': _private,
        'phones': _phones,
        'delete': _delete,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'private': serializeParam(
          _private,
          ParamType.bool,
        ),
        'phones': serializeParam(
          _phones,
          ParamType.String,
          isList: true,
        ),
        'delete': serializeParam(
          _delete,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static CriarGrupoStruct fromSerializableMap(Map<String, dynamic> data) =>
      CriarGrupoStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        private: deserializeParam(
          data['private'],
          ParamType.bool,
          false,
        ),
        phones: deserializeParam<String>(
          data['phones'],
          ParamType.String,
          true,
        ),
        delete: deserializeParam<int>(
          data['delete'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'CriarGrupoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CriarGrupoStruct &&
        name == other.name &&
        private == other.private &&
        listEquality.equals(phones, other.phones) &&
        listEquality.equals(delete, other.delete);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, private, phones, delete]);
}

CriarGrupoStruct createCriarGrupoStruct({
  String? name,
  bool? private,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CriarGrupoStruct(
      name: name,
      private: private,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CriarGrupoStruct? updateCriarGrupoStruct(
  CriarGrupoStruct? criarGrupo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    criarGrupo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCriarGrupoStructData(
  Map<String, dynamic> firestoreData,
  CriarGrupoStruct? criarGrupo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (criarGrupo == null) {
    return;
  }
  if (criarGrupo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && criarGrupo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final criarGrupoData = getCriarGrupoFirestoreData(criarGrupo, forFieldValue);
  final nestedData = criarGrupoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = criarGrupo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCriarGrupoFirestoreData(
  CriarGrupoStruct? criarGrupo, [
  bool forFieldValue = false,
]) {
  if (criarGrupo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(criarGrupo.toMap());

  // Add any Firestore field values
  criarGrupo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCriarGrupoListFirestoreData(
  List<CriarGrupoStruct>? criarGrupos,
) =>
    criarGrupos?.map((e) => getCriarGrupoFirestoreData(e, true)).toList() ?? [];
