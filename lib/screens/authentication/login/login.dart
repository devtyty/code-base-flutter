import 'package:beefood_app/view_model/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
part 'login.logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late _BusinessLogic _businessLogic;

  double get padding => MediaQuery.of(context).size.height * 0.02;

  @override
  void initState() {
    _businessLogic = _BusinessLogic(context);
    super.initState();
  }

  @override
  void dispose() {
    _businessLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _businessLogic,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              TextFormField(
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: padding),
              TextFormField(
                cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: padding),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _businessLogic.login,
                  child: const Text('Login'),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
