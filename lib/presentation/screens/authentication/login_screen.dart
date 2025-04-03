import 'dart:convert';
import 'package:apparel_360/presentation/screens/authentication/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_style/app_color.dart';
import '../../../core/contents/assets_path.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/repository.dart';
import '../../../core/utils/app_constant.dart';
import '../../component/button_control/ButtonControl.dart';
import '../../component/button_control/button_proprty.dart';
import '../../component/textbox_control/text_field_widget.dart';
import '../../component/textbox_control/textbox_property.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneControl = TextEditingController();
  final repository = NetworkRepository(BaseClient());

  @override
  void initState() {
    super.initState();
    //  initialize();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetsPath.loginImage,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppConstant.login,
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppConstant.mobile,
                  style: TextStyle(
                      color: AppColor.black900,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: SizedBox(
                  child: TextBoxComponent(
                textBoxProperty: TextBoxProperty(
                    label: "",
                    textStyle: const TextStyle(color: Colors.red),
                    inputType: TextInputType.number,
                    maxLength: 10),
                onChanged: (value) {
                  _phoneControl.text = value.toString();
                },
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0, left: 16, right: 16),
              child: ButtonControl(
                onTap: () async {
                  if (_phoneControl.text.length == 10 &&
                      RegExp(r'^[6-9]\d{9}$').hasMatch(_phoneControl.text)) {
                    postLoginData(_phoneControl.text, "12345678");
                  } else {
                    // Fluttertoast.showToast(
                    //   msg: "Enter a valid 10-digit mobile number",
                    // );
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48,left: 24),
                child: Center(
                  child: Text(
                    AppConstant.termAndCondition,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postLoginData(String mobileNo, String password) async {
    final data = await repository.login(mobileNo, password);
    if (data["type"] == "success") {
      var otp = data['data']['otp'];
      var number = data['data']['mobileNo'];
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(number: mobileNo, otp: otp),
          ),
        );
      }
    }
  }
}
