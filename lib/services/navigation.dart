import 'package:beefood_app/routes/routes.dart';
import 'package:flutter/widgets.dart' show NavigatorState, GlobalKey;
import 'package:get_it/get_it.dart';

class NavigationService {
  static NavigatorState get _navState =>
      GetIt.instance.get<GlobalKey<NavigatorState>>().currentState!;

  /// Goto auth stack screens
  static Future<T?> gotoAuth<T extends Object?>() {
    return _navState.pushNamedAndRemoveUntil(
      AppRoutes.auth,
      (route) => false,
    );
  }

  ///Goto app stack screens
  static Future<T?> gotoAppStack<T extends Object?>() {
    return _navState.pushNamedAndRemoveUntil(
      AppRoutes.appStack,
      (route) => false,
    );
  }
}
