import 'package:apparel_360/presentation/screens/catelog.dart';
import 'package:apparel_360/presentation/screens/login.dart';
import 'package:apparel_360/presentation/screens/otp.dart';
import 'package:apparel_360/routes.dart';
import 'package:flutter/cupertino.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const LoginScreen());
      case Routes.otpScreen:
        return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
                OtpScreen(number: '000000002', otp: '1234',)
        );
      case Routes.catelog:
        return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const Catelog());
    }
    return null;
  }
}
