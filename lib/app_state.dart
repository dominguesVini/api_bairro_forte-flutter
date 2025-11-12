import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_configUsuario')) {
        try {
          final serializedData = prefs.getString('ff_configUsuario') ?? '{}';
          _configUsuario = ConfigUsuarioStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _userId = prefs.getInt('ff_userId') ?? _userId;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// Variavel para  capturar a latitude  e  longitude do mapa
  LatLng? _LatLongRegistro = LatLng(-25.3888928, -51.4612388);
  LatLng? get LatLongRegistro => _LatLongRegistro;
  set LatLongRegistro(LatLng? value) {
    _LatLongRegistro = value;
  }

  String _dataRegistro = '01/01/9999';
  String get dataRegistro => _dataRegistro;
  set dataRegistro(String value) {
    _dataRegistro = value;
  }

  DateTime? _dataRegistroApi =
      DateTime.fromMillisecondsSinceEpoch(1744148520000);
  DateTime? get dataRegistroApi => _dataRegistroApi;
  set dataRegistroApi(DateTime? value) {
    _dataRegistroApi = value;
  }

  String _Email = '';
  String get Email => _Email;
  set Email(String value) {
    _Email = value;
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
  }

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  String _sexo = '';
  String get sexo => _sexo;
  set sexo(String value) {
    _sexo = value;
  }

  CameraStruct _camera = CameraStruct();
  CameraStruct get camera => _camera;
  set camera(CameraStruct value) {
    _camera = value;
  }

  void updateCameraStruct(Function(CameraStruct) updateFn) {
    updateFn(_camera);
  }

  IncidentStruct _Incident = IncidentStruct();
  IncidentStruct get Incident => _Incident;
  set Incident(IncidentStruct value) {
    _Incident = value;
  }

  void updateIncidentStruct(Function(IncidentStruct) updateFn) {
    updateFn(_Incident);
  }

  FiltrosStruct _filtros = FiltrosStruct();
  FiltrosStruct get filtros => _filtros;
  set filtros(FiltrosStruct value) {
    _filtros = value;
  }

  void updateFiltrosStruct(Function(FiltrosStruct) updateFn) {
    updateFn(_filtros);
  }

  ConfigUsuarioStruct _configUsuario = ConfigUsuarioStruct();
  ConfigUsuarioStruct get configUsuario => _configUsuario;
  set configUsuario(ConfigUsuarioStruct value) {
    _configUsuario = value;
    prefs.setString('ff_configUsuario', value.serialize());
  }

  void updateConfigUsuarioStruct(Function(ConfigUsuarioStruct) updateFn) {
    updateFn(_configUsuario);
    prefs.setString('ff_configUsuario', _configUsuario.serialize());
  }

  String _telefone = '';
  String get telefone => _telefone;
  set telefone(String value) {
    _telefone = value;
  }

  List<IncidentesStruct> _incidentes = [];
  List<IncidentesStruct> get incidentes => _incidentes;
  set incidentes(List<IncidentesStruct> value) {
    _incidentes = value;
  }

  void addToIncidentes(IncidentesStruct value) {
    incidentes.add(value);
  }

  void removeFromIncidentes(IncidentesStruct value) {
    incidentes.remove(value);
  }

  void removeAtIndexFromIncidentes(int index) {
    incidentes.removeAt(index);
  }

  void updateIncidentesAtIndex(
    int index,
    IncidentesStruct Function(IncidentesStruct) updateFn,
  ) {
    incidentes[index] = updateFn(_incidentes[index]);
  }

  void insertAtIndexInIncidentes(int index, IncidentesStruct value) {
    incidentes.insert(index, value);
  }

  List<CameraStruct> _cameras = [];
  List<CameraStruct> get cameras => _cameras;
  set cameras(List<CameraStruct> value) {
    _cameras = value;
  }

  void addToCameras(CameraStruct value) {
    cameras.add(value);
  }

  void removeFromCameras(CameraStruct value) {
    cameras.remove(value);
  }

  void removeAtIndexFromCameras(int index) {
    cameras.removeAt(index);
  }

  void updateCamerasAtIndex(
    int index,
    CameraStruct Function(CameraStruct) updateFn,
  ) {
    cameras[index] = updateFn(_cameras[index]);
  }

  void insertAtIndexInCameras(int index, CameraStruct value) {
    cameras.insert(index, value);
  }

  CriarGrupoStruct _criarGrupo = CriarGrupoStruct();
  CriarGrupoStruct get criarGrupo => _criarGrupo;
  set criarGrupo(CriarGrupoStruct value) {
    _criarGrupo = value;
  }

  void updateCriarGrupoStruct(Function(CriarGrupoStruct) updateFn) {
    updateFn(_criarGrupo);
  }

  String _lastUserEmail = '';
  String get lastUserEmail => _lastUserEmail;
  set lastUserEmail(String value) {
    _lastUserEmail = value;
  }

  int _userId = 0;
  int get userId => _userId;
  set userId(int value) {
    _userId = value;
    prefs.setInt('ff_userId', value);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
  }

  String _cidade = '';
  String get cidade => _cidade;
  set cidade(String value) {
    _cidade = value;
  }

  String _uf = '';
  String get uf => _uf;
  set uf(String value) {
    _uf = value;
  }

  bool _emailSendVerification = false;
  bool get emailSendVerification => _emailSendVerification;
  set emailSendVerification(bool value) {
    _emailSendVerification = value;
  }

  int _idCidade = 0;
  int get idCidade => _idCidade;
  set idCidade(int value) {
    _idCidade = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
