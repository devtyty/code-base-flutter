import 'package:beefood_app/screens/app/home/home.dart';
import 'package:beefood_app/screens/app/product_detail/product_detail.dart';
import 'package:beefood_app/screens/auth_loading/auth_loading.dart';
import 'package:beefood_app/screens/authentication/login/login.dart';
import 'package:beefood_app/screens/authentication/signup/signup.dart';

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._();

  AppRoutes._();

  ///This is [instance] of [AppRoutes]
  factory AppRoutes() => _instance;

  ///This is [instance] of [AppRoutes]
  static AppRoutes get instance => _instance;

  Map<String, dynamic> routesConfig = {
    root: (_) => const AuthLoadingPage(),
    appStack: {
      homePage: (_) => const HomePage(),
      productDetailPage: (_) => const ProductDetailPage(),
    },
    auth: {
      loginPage: (_) => const LoginPage(),
      signupPage: (_) => const SignUpPage(),
    }
  };

  //Route Names
  static const root = '/';

  //Authentication
  static const auth = '/auth';
  static const loginPage = '/login';
  static const signupPage = '/sign-up';

  //App Stack
  static const appStack = '/app';
  static const homePage = '/app/home';
  static const productDetailPage = '/home/product-detail';
}
