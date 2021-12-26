import 'package:beefood_app/routes/routes.dart';
import 'package:beefood_app/view_model/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'injection.dart';
import 'packages/nested_navigation.dart';

void main() async {
  await configurationDepenInjection();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => GetIt.instance.get<AppVM>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: GetIt.instance.get<GlobalKey<NavigatorState>>(),
          title: 'Beefoods',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: (settings) => generateRoute(
            settings,
            AppRoutes().routesConfig,
          ),
        ),
      ),
    );
  }
}
