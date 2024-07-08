import 'package:flutter/material.dart';
import 'package:untitled/utils/routes/route_name.dart';
import 'package:untitled/view/forgot_password/forgot_password.dart';
import '../../view/dashboasrd/dashboard.dart';
import '../../view/login/login_screen.dart';
import '../../view/signup/sign_up_screen.dart';
import '../../view/splash/splash_screen.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case RouteName.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoard());

      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}