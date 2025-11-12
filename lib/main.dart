import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

import 'custom_code/actions/index.dart' as actions;


import 'package:workmanager/workmanager.dart';

import 'dart:io';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'custom_code/actions/adicionar_lat_long_atual_na_estrutura.dart';

/// HttpOverrides that accepts any SSL certificate - development only.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();
   //await actions.onesignal();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.entryPage});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  final Widget? entryPage;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  Timer? _locationUpdateTimer;

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier, widget.entryPage);
    userStream = bairroForteFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);

        // Salvar o email do usuário no FFAppState para referência em background
        final email = user.email;
        if (email != null && email.isNotEmpty) {
          FFAppState().update(() {
            FFAppState().lastUserEmail = email;
          });
        }
      });

    jwtTokenStream.listen((_) {

      // Tenta enviar localizações pendentes se houver
      _checkForPendingLocations();
    });

    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );

    // Execute imediatamente a action
    _executeLocationUpdate();

    // Configura o timer para executar a action a cada 5 SEGUNDOS quando o app estiver aberto
    // Isso garante atualizações muito frequentes enquanto o app está em primeiro plano
    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 5), // A cada 5 segundos
      (_) => _executeLocationUpdate(),
    );

    // Agenda tarefas one-off adicionais a cada 60 segundos
    // Isso ajuda a aumentar a frequência quando o app está em background recente
    Timer.periodic(
      const Duration(seconds: 60),
      (_) {
        _scheduleAdditionalLocationUpdate();
      },
    );
  }

  // Método para executar a action de atualização de localização
  void _executeLocationUpdate() async {
    try {

      // Verifica conexão antes de tentar atualizar
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      final result = await adicionarLatLongAtualNaEstrutura();

    } catch (e) {
    }
  }

  // Método para agendar uma atualização adicional de localização
  void _scheduleAdditionalLocationUpdate() async {
    try {
      // Agendar tarefas com tempos escalonados para cobrir o próximo minuto
      // Isto permite maior frequência de atualizações de localização em background

      // Tarefas em intervalos curtos para próximos minutos
      final uniqueId1 =
          'location-update-${DateTime.now().millisecondsSinceEpoch}-1';
      await Workmanager().registerOneOffTask(
        uniqueId1,
        'minute-location-update',
        initialDelay: const Duration(seconds: 15),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {
          'scheduled_at': DateTime.now().toString(),
          'reason': 'Atualização de localização a cada 15 segundos'
        },
      );

      final uniqueId2 =
          'location-update-${DateTime.now().millisecondsSinceEpoch}-2';
      await Workmanager().registerOneOffTask(
        uniqueId2,
        'minute-location-update',
        initialDelay: const Duration(seconds: 30),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {
          'scheduled_at': DateTime.now().toString(),
          'reason': 'Atualização de localização a cada 30 segundos'
        },
      );

      final uniqueId3 =
          'location-update-${DateTime.now().millisecondsSinceEpoch}-3';
      await Workmanager().registerOneOffTask(
        uniqueId3,
        'minute-location-update',
        initialDelay: const Duration(seconds: 45),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {
          'scheduled_at': DateTime.now().toString(),
          'reason': 'Atualização de localização a cada 45 segundos'
        },
      );

      // Agendar também tarefas de backup em intervalos mais longos
      final backupId1 =
          'backup-location-${DateTime.now().millisecondsSinceEpoch}-1';
      await Workmanager().registerOneOffTask(
        backupId1,
        'oneoff-location-update',
        initialDelay: const Duration(minutes: 2),
        existingWorkPolicy: ExistingWorkPolicy.keep,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        inputData: {
          'scheduled_at': DateTime.now().toString(),
          'reason': 'Backup de localização - 2 minutos'
        },
      );

      
    } catch (e) {
    }
  }

  // Verifica se há localizações pendentes para enviar
  void _checkForPendingLocations() async {
    try {} catch (e) {
    }
  }

  @override
  void dispose() {
    // Cancela o timer quando o widget for descartado
    _locationUpdateTimer?.cancel();
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bairro Forte',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('pt'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'mapaDinamico';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'mapaDinamico': MapaDinamicoWidget(),
      'perfil': PerfilWidget(),
      'faq_duvidas': FaqDuvidasWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).corPrimaria,
        selectedItemColor: FlutterFlowTheme.of(context).primaryBackground,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        selectedBackgroundColor: Color(0x00000000),
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.mapMarkedAlt,
                  color: currentIndex == 0
                      ? FlutterFlowTheme.of(context).primaryBackground
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'mapa',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 0
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_sharp,
                  color: currentIndex == 1
                      ? FlutterFlowTheme.of(context).primaryBackground
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'perfil',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 1
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline_outlined,
                  color: currentIndex == 2
                      ? FlutterFlowTheme.of(context).primaryBackground
                      : FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                Text(
                  'Dúvidas',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: currentIndex == 2
                        ? FlutterFlowTheme.of(context).primaryBackground
                        : FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
