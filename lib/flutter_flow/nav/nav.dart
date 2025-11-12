import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier, [Widget? entryPage]) =>
    GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? entryPage ?? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.loggedIn
              ? entryPage ?? NavBarPage()
              : LoginWidget(),
        ),
        FFRoute(
          name: MapaDinamicoWidget.routeName,
          path: MapaDinamicoWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'mapaDinamico')
              : MapaDinamicoWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: CreateAccount01Widget.routeName,
          path: CreateAccount01Widget.routePath,
          builder: (context, params) => CreateAccount01Widget(),
        ),
        FFRoute(
          name: CreateAccount02Widget.routeName,
          path: CreateAccount02Widget.routePath,
          builder: (context, params) => CreateAccount02Widget(),
        ),
        FFRoute(
          name: CreateAccount03Widget.routeName,
          path: CreateAccount03Widget.routePath,
          builder: (context, params) => CreateAccount03Widget(),
        ),
        FFRoute(
          name: CreateAccount04Widget.routeName,
          path: CreateAccount04Widget.routePath,
          builder: (context, params) => CreateAccount04Widget(),
        ),
        FFRoute(
          name: CreateAccount05Widget.routeName,
          path: CreateAccount05Widget.routePath,
          builder: (context, params) => CreateAccount05Widget(),
        ),
        FFRoute(
          name: CreateAccount06Widget.routeName,
          path: CreateAccount06Widget.routePath,
          builder: (context, params) => CreateAccount06Widget(),
        ),
        FFRoute(
          name: CreateAccount07Widget.routeName,
          path: CreateAccount07Widget.routePath,
          builder: (context, params) => CreateAccount07Widget(
            phoneNumber: params.getParam(
              'phoneNumber',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: PerfilWidget.routeName,
          path: PerfilWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'perfil')
              : PerfilWidget(),
        ),
        FFRoute(
          name: CamerasWidget.routeName,
          path: CamerasWidget.routePath,
          builder: (context, params) => CamerasWidget(),
        ),
        FFRoute(
          name: AddCameraWidget.routeName,
          path: AddCameraWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AddCameraWidget(),
        ),
        FFRoute(
          name: EditCameraWidget.routeName,
          path: EditCameraWidget.routePath,
          builder: (context, params) => EditCameraWidget(
            description: params.getParam(
              'description',
              ParamType.String,
            ),
            isPrivado: params.getParam(
              'isPrivado',
              ParamType.bool,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: NotificationsWidget.routeName,
          path: NotificationsWidget.routePath,
          builder: (context, params) => NotificationsWidget(),
        ),
        FFRoute(
          name: GroupsWidget.routeName,
          path: GroupsWidget.routePath,
          builder: (context, params) => GroupsWidget(),
        ),
        FFRoute(
          name: PreferencesConfigurationWidget.routeName,
          path: PreferencesConfigurationWidget.routePath,
          requireAuth: true,
          builder: (context, params) => PreferencesConfigurationWidget(
            isCadastro: params.getParam(
              'isCadastro',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: ConfGeralWidget.routeName,
          path: ConfGeralWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ConfGeralWidget(),
        ),
        FFRoute(
          name: RotasWidget.routeName,
          path: RotasWidget.routePath,
          builder: (context, params) => RotasWidget(),
        ),
        FFRoute(
          name: CadastrarRotasWidget.routeName,
          path: CadastrarRotasWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CadastrarRotasWidget(),
        ),
        FFRoute(
          name: DetalhesRotasWidget.routeName,
          path: DetalhesRotasWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetalhesRotasWidget(),
        ),
        FFRoute(
          name: MeusUsuariosWidget.routeName,
          path: MeusUsuariosWidget.routePath,
          builder: (context, params) => MeusUsuariosWidget(),
        ),
        FFRoute(
          name: DadosUsuariosWidget.routeName,
          path: DadosUsuariosWidget.routePath,
          builder: (context, params) => DadosUsuariosWidget(),
        ),
        FFRoute(
          name: ConfPrivacidadeWidget.routeName,
          path: ConfPrivacidadeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ConfPrivacidadeWidget(),
        ),
        FFRoute(
          name: DetalhesGrupoWidget.routeName,
          path: DetalhesGrupoWidget.routePath,
          builder: (context, params) => DetalhesGrupoWidget(
            groupId: params.getParam(
              'groupId',
              ParamType.int,
            ),
            isDono: params.getParam(
              'isDono',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: RelatoriosWidget.routeName,
          path: RelatoriosWidget.routePath,
          builder: (context, params) => RelatoriosWidget(),
        ),
        FFRoute(
          name: TelaRelatorioWidget.routeName,
          path: TelaRelatorioWidget.routePath,
          requireAuth: true,
          builder: (context, params) => TelaRelatorioWidget(),
        ),
        FFRoute(
          name: FaqDuvidasWidget.routeName,
          path: FaqDuvidasWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'faq_duvidas')
              : FaqDuvidasWidget(),
        ),
        FFRoute(
          name: DetalhesRotaWidget.routeName,
          path: DetalhesRotaWidget.routePath,
          builder: (context, params) => DetalhesRotaWidget(),
        ),
        FFRoute(
          name: CriarGrupoWidget.routeName,
          path: CriarGrupoWidget.routePath,
          builder: (context, params) => CriarGrupoWidget(),
        ),
        FFRoute(
          name: DadosUsuarioWidget.routeName,
          path: DadosUsuarioWidget.routePath,
          builder: (context, params) => DadosUsuarioWidget(),
        ),
        FFRoute(
          name: NotificatiosWidget.routeName,
          path: NotificatiosWidget.routePath,
          builder: (context, params) => NotificatiosWidget(),
        ),
        FFRoute(
          name: MudarSenhaWidget.routeName,
          path: MudarSenhaWidget.routePath,
          builder: (context, params) => MudarSenhaWidget(),
        ),
        FFRoute(
          name: IncidentesWidget.routeName,
          path: IncidentesWidget.routePath,
          builder: (context, params) => IncidentesWidget(),
        ),
        FFRoute(
          name: DetalhesIncidenteWidget.routeName,
          path: DetalhesIncidenteWidget.routePath,
          builder: (context, params) => DetalhesIncidenteWidget(
            incidentId: params.getParam(
              'incidentId',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: EntrarEmUmGrupoWidget.routeName,
          path: EntrarEmUmGrupoWidget.routePath,
          builder: (context, params) => EntrarEmUmGrupoWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Color(0x00FFFFFF),
                  child: Image.asset(
                    'assets/images/screen.png',
                    fit: BoxFit.cover,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
