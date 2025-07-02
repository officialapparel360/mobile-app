import 'dart:async';
import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/screens/authentication/detail_input_screen.dart';
import 'package:flutter/material.dart';
import '../../core/contents/assets_path.dart';
import '../../data/prefernce/shared_preference.dart';
import 'authentication/login_screen.dart';
import 'dashboard/tab_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    startTime();
  }

  void _checkLoginStatus() async {
    isLoggedIn = await SharedPrefHelper.getLoginStatus();

    print("Is Logged In Splash: $isLoggedIn");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 40,
            child: Image.asset(
              'assets/images/loading_page.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    Timer(_duration, () => navigateLogic(context));
  }

  void navigateLogic(BuildContext context) async {
    bool isLoginFormRequiredAndNotFilled =
        await SharedPrefHelper.getLoginFormRequiredAndNotFilled();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => isLoginFormRequiredAndNotFilled
              ? DetailsInputScreen()
              : isLoggedIn
                  ? const Dashboard()
                  : const LoginScreen()),
    );
  }
}
