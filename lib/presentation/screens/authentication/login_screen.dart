import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/core/utils/show_custom_toast.dart';
import 'package:apparel_360/presentation/screens/authentication/bloc/login_bloc.dart';
import 'package:apparel_360/presentation/screens/authentication/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_style/app_color.dart';
import '../../../core/contents/assets_path.dart';
import '../../../core/utils/app_constant.dart';
import '../../component/button_control/ButtonControl.dart';
import '../../component/button_control/button_proprty.dart';
import '../../component/textbox_control/text_field_widget.dart';
import '../../component/textbox_control/textbox_property.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneControl = TextEditingController();
  late LoginBloc bloc;
  bool isOtpSent = false;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc(LoginInitialState());
  }

  @override
  Widget build(BuildContext context1) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => bloc,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocConsumer<LoginBloc, LoginState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is GetOtpLoadingState) {
                    isOtpSent = true;
                  } else if (state is GetOtpSuccessState) {
                    isOtpSent = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                            number: _phoneControl.text, otp: state.otp),
                      ),
                    );
                  } else if (state is GetOtpFailState) {
                    Fluttertoast.showToast(msg: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 140.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: screenSize.width * 0.8,
                              width: screenSize.width,
                              child: Image.asset(
                                AssetsPath.loginImage,
                              ),
                            ),
                            Text(
                              AppConstant.welcomeApparels360,
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 24.0, top: 16),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppConstant.mobile,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: SizedBox(
                                      width: screenSize.width / 1.8,
                                      child: TextBoxComponent(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        textBoxProperty: TextBoxProperty(
                                          hintText: 'eg. 9876543210',
                                          hintStyle: TextStyle(
                                              color: AppColor.grey,
                                              fontSize: 14.0),
                                          textStyle: TextStyle(
                                              color: AppColor.black700,
                                              fontSize: 16.0),
                                          inputType: TextInputType.number,
                                        ),
                                        onChanged: (value) {
                                          _phoneControl.text = value.toString();
                                          if (value.length == 10) {
                                            FocusScope.of(context)
                                                .unfocus(); // ✅ close keyboard
                                          }
                                        },
                                      )),
                                ),
                                isOtpSent
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        ),
                                      )
                                    : ButtonControl(
                                        onTap: () async {
                                          postLoginData(_phoneControl.text);
                                        },
                                        borderRadius: 14.0,
                                        textPadding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        buttonProperty: ButtonProperty(
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          text: 'Get OTP',
                                          textColor: Colors.white,
                                        ),
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, top: 30.0),
                              child: SizedBox(
                                width: screenSize.width * 0.8,
                                child: Text(
                                  AppConstant.termAndCondition,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.black700,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  postLoginData(String mobileNo) {
    if (_phoneControl.text.isNotEmpty &&
        _phoneControl.text.length == 10 &&
        RegExp(r'^[6-9]\d{9}$').hasMatch(_phoneControl.text)) {
      bloc.add(GetOtpEvent(mobileNumber: mobileNo));
    } else {
      CustomToast.showToast("Enter a valid 10-digit mobile number");
    }
  }
}
