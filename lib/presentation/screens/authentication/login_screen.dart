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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocListener<LoginBloc, LoginState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is GetOtpLoadingState) {
                    AppHelper().showFullScreenLoader(context);
                  } else if (state is GetOtpSuccessState) {
                    Navigator.pushReplacement(
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
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.5,
                          width: screenSize.width,
                          child: Image.asset(
                            AssetsPath.loginImage,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0, top: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppConstant.mobile,
                              style: TextStyle(
                                  color: AppColor.black600,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.grey)),
                            child: TextBoxComponent(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              textBoxProperty: TextBoxProperty(
                                label: "",
                                textStyle: TextStyle(
                                    color: AppColor.black700, fontSize: 18.0),
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
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 20.0),
                          child: ButtonControl(
                            onTap: () async {
                              postLoginData(_phoneControl.text);
                            },
                            textPadding:
                                const EdgeInsets.symmetric(vertical: 12.0),
                            buttonProperty: ButtonProperty(
                              backgroundColor: AppColor.primaryColor,
                              buttonSize: Size(screenSize.width, 50.0),
                              text: AppConstant.submit,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postLoginData(String mobileNo) {
    if (_phoneControl.text.length == 10 &&
        RegExp(r'^[6-9]\d{9}$').hasMatch(_phoneControl.text)) {
      bloc.add(GetOtpEvent(mobileNumber: mobileNo));
    } else {
      CustomToast.showToast("Enter a valid 10-digit mobile number");
    }
  }
}
