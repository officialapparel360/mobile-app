import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/network/base_client.dart';
import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/utils/app_constant.dart';
import 'package:apparel_360/presentation/component/button_control/ButtonControl.dart';
import 'package:apparel_360/presentation/component/button_control/button_proprty.dart';
import 'package:apparel_360/presentation/screens/authentication/detail_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:apparel_360/core/network/network_utils.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:apparel_360/presentation/screens/dashboard/tab_bar.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  final String number;

  const OtpScreen({super.key, required this.number, required this.otp});

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
      appBar: AppBar(
        title: const Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Enter 6-digit OTP sent to your phone",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenSize.width - 62,
              height: 50.0,
              child: Pinput(
                length: 6,
                controller: _otpController,
                keyboardType: TextInputType.number,
                onCompleted: (pin) => _verifyOtp(),
              ),
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
                  buttonSize: Size(screenSize.width, 50.0),
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
    bool isInternetAvailable = await ConnectionUtil().checkInternetStatus();
    if (isInternetAvailable) {
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

        data["data"]["isFirstLogin"];
        if (data["data"]["isFirstLogin"] == 0 && data["data"]["roleID"] == 3) {
          await SharedPrefHelper.setLoginFormRequiredAndNotFilled(true);
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => DetailsInputScreen()),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => Dashboard()),
              (route) => false,
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data["message"])),
          );
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    }
  }
}
