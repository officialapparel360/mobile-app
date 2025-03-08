import 'dart:async';

import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import '../../core/contents/assets_path.dart';
import '../../data/prefernce/shared_preference.dart';
import 'login.dart';

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
        backgroundColor: AppColor.backgroundSplashColor,
        body: Center(
          child: Image.asset(
            AssetsPath.logo,
          ),
        ));
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    Timer(_duration, () => navigateLogic(context));
  }

  void navigateLogic(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => isLoggedIn ? const Dashboard() : const LoginScreen()),
    );
  }
}
