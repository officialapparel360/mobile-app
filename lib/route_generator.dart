import 'package:apparel_360/presentation/screens/authentication/otp_screen.dart';
import 'package:apparel_360/presentation/screens/authentication/login_screen.dart';
import 'package:apparel_360/presentation/screens/dashboard/chat-component/chat_screen.dart';
import 'package:apparel_360/presentation/screens/dashboard/home-component/home_screen.dart';
import 'package:apparel_360/presentation/screens/catelog/catelog.dart';
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
                OtpScreen(
                  number: '000000002',
                  otp: '1234',
                ));
      case Routes.catelog:
        return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                const Catelog());
      // case Routes.homeScreen:
      //   return PageRouteBuilder(
      //       pageBuilder: (BuildContext context, Animation<double> animation,
      //               Animation<double> secondaryAnimation) =>
      //           const HomeScreen());
      case Routes.chatScreen:
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final args = settings.arguments as Map<String, String>?;

            return ChatScreen(
              receiverUserID: args?['receiverId'] ?? '',
              senderUserID: args?['senderId'] ?? '',
            );
          },
        );
    }
    return null;
  }
}
