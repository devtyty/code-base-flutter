import 'package:flutter/material.dart';

typedef FunctionBuilder = Widget Function(BuildContext);

class NestedNavigation<T> extends ModalRoute<T> {
  final String initRoute;
  final Route<dynamic>? Function(RouteSettings settings) onGenerateRoute;
  final bool barrierDismiss;
  final Duration? duration;

  final GlobalKey<NavigatorState> _navState = GlobalKey();

  NestedNavigation({
    required this.initRoute,
    required this.onGenerateRoute,
    this.barrierDismiss = false,
    this.duration,
  });

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => barrierDismiss;

  @override
  String? get barrierLabel => '$initRoute Stack';

  @override
  Future<RoutePopDisposition> willPop() async {
    if (_navState.currentState!.canPop()) {
      _navState.currentState!.pop();
    }
    return Future.value(RoutePopDisposition.doNotPop);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Navigator(
      key: _navState,
      initialRoute: initRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      duration ?? const Duration(milliseconds: 300);
}

Route<dynamic>? _getRoute(dynamic pageRoute, RouteSettings settings) {
  if (pageRoute is Route) {
    return pageRoute;
  }

  if (pageRoute is FunctionBuilder) {
    return MaterialPageRoute(
      builder: pageRoute,
      settings: settings,
    );
  }

  if (pageRoute is Map) {
    return NestedNavigation(
        initRoute: '${pageRoute.keys.first}',
        onGenerateRoute: (_settings) =>
            generateRoute(_settings, pageRoute as Map<String, dynamic>));
  }
}

Route<dynamic>? generateRoute(
    RouteSettings settings, Map<String, dynamic> routes) {
  var pageRoute = routes[settings.name];

  return _getRoute(pageRoute, settings);
}
