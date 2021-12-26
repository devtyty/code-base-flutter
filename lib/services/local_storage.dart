import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();
  static const String jwtToken = 'TOKEN';

  SharedPreferences? _pref;

  SharedPreferences get store => _pref!;

  LocalStorage._();

  factory LocalStorage() => _instance;

  static LocalStorage get instance => _instance;

  static Future<void> init() async {
    instance._pref ??= await SharedPreferences.getInstance();
    return Future.value();
  }

  set token(String token) {
    store.setString(LocalStorage.jwtToken, token);
  }

  String get token => store.getString(LocalStorage.jwtToken) ?? '';
}
