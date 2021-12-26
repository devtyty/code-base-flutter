import 'package:beefood_app/models/user/user.dart';
import 'package:beefood_app/view_model/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> configurationDepenInjection() async {
  var getIt = GetIt.instance;

  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(() => GlobalKey());
  getIt.registerLazySingleton<AppVM>(() => AppVM());
  getIt.registerSingleton(() => User.withEmpty());

  return Future.value();
}
