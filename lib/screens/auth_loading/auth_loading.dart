import 'dart:async';

import 'package:beefood_app/gen/assets.gen.dart';
import 'package:beefood_app/view_model/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class AuthLoadingPage extends StatefulWidget {
  const AuthLoadingPage({Key? key}) : super(key: key);

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4500), () {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        GetIt.instance.get<AppVM>().authPending();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Align(
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: LottieBuilder.asset(Assets.lotties.faceScanning),
          ),
        ),
      ),
    );
  }
}
