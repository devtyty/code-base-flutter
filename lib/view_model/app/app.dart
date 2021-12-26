import 'package:beefood_app/services/local_storage.dart';
import 'package:beefood_app/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

enum AuthState { nonLogged, logged }

class AppVM with ChangeNotifier {
  AuthState authState = AuthState.nonLogged;
  String token = '';

  bool get isLogged => authState == AuthState.logged;

  void logged(String _token) {
    authState = AuthState.logged;
    token = _token;

    LocalStorage().token = _token;
    notifyListeners();

    NavigationService.gotoAppStack();
  }

  void logout() {
    authState = AuthState.nonLogged;
    LocalStorage().token = '';
    notifyListeners();

    NavigationService.gotoAuth();
  }

  /// Middleware to authen when into app
  Future<dynamic> authPending() async {
    await LocalStorage.init();

    if (LocalStorage().token.isEmpty) {
      return NavigationService.gotoAuth();
    }

    return NavigationService.gotoAppStack();
  }
}
