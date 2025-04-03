import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/network/base_client.dart';
import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
import 'package:apparel_360/presentation/component/button_control/ButtonControl.dart';
import 'package:apparel_360/presentation/component/button_control/button_proprty.dart';
import 'package:apparel_360/routes.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

import '../../../data/prefernce/shared_preference.dart';
import '../dashboard/home-component/home_screen.dart';
import '../dashboard/tab_bar.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String number;

  OtpScreen({super.key, required this.number, required this.otp});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final repository = NetworkRepository(BaseClient());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP: ${widget.otp}")),
      );
    });
  }

  void _verifyOtp() {
    String enteredOtp = _otpController.text;
    if (enteredOtp.length == 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Entered: $enteredOtp")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 28),
              child: Text(
                "OTP Verification",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter 6-digit OTP sent to your phone",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Pinput(
              length: 6,
              controller: _otpController,
              keyboardType: TextInputType.number,
              onCompleted: (pin) => _verifyOtp(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Don't  receive the OTP? RESEND",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(top: 36.0, left: 16, right: 16),
              child: ButtonControl(
                onTap: () async {
                  if (_otpController.text.isEmpty ||
                      _otpController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter a valid 6-digit OTP")),
                    );
                  } else {
                    verifyOtp(_otpController.text.toString());
                  }
                },
                textPadding: const EdgeInsets.symmetric(vertical: 12.0),
                buttonProperty: ButtonProperty(
                  backgroundColor: AppColor.primaryColor,
                  buttonSize: Size(screenSize.width, 0.0),
                  text: AppConstant.submit,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtp(String otp) async {
    final data = await repository.otpVerify({
      "mobileNo": widget.number,
      "otp": otp,
    });

    if (data["type"] == "success") {
      await SharedPrefHelper.saveUserId(data["data"]["userID"]);
      await SharedPrefHelper.setLoginStatus(true);
      bool isLoggedIn = await SharedPrefHelper.getLoginStatus();
      var userId = await SharedPrefHelper.getUserId();
      print("Is Logged In: $isLoggedIn === $userId");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );
      }
    }
  }
}
