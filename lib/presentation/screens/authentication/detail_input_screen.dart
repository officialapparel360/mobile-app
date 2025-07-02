import 'dart:io';

import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/core/app_style/app_text_style.dart';
import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:apparel_360/core/utils/app_helper.dart';
import 'package:apparel_360/core/utils/show_custom_toast.dart';
import 'package:apparel_360/data/prefernce/shared_preference.dart';
import 'package:apparel_360/presentation/component/button_control/ButtonControl.dart';
import 'package:apparel_360/presentation/component/button_control/button_proprty.dart';
import 'package:apparel_360/presentation/component/textbox_control/text_field_widget.dart';
import 'package:apparel_360/presentation/component/textbox_control/textbox_property.dart';
import 'package:apparel_360/presentation/screens/authentication/product_quantity_dropdown_widget.dart';
import 'package:apparel_360/presentation/screens/dashboard/tab_bar.dart';
import 'package:apparel_360/presentation/screens/profile/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DetailsInputScreen extends StatefulWidget {
  @override
  State<DetailsInputScreen> createState() => _DetailsInputScreenState();
}

class _DetailsInputScreenState extends State<DetailsInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shopController = TextEditingController();
  final _gstController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();

  bool isScreenLoading = false;
  String selectedQty = '50';
  final List<String> qtyOptions = ['50', '100', '200', '300', '400', '500'];
  String uploadedImage = '';
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar:
            AppBar(title: const Text("Business Details"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfilePicWidget(
                      networkImage: uploadedImage,
                      pickImage: () {
                        pickImage();
                      }),
                ),
                Text(
                  'Your Name*',
                  style: AppTextStyle.getFont14Style(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: TextBoxComponent(
                    controller: _nameController,
                    textBoxProperty: TextBoxProperty(hintText: 'Name'),
                  ),
                ),
                Text(
                  'Shop Name*',
                  style: AppTextStyle.getFont14Style(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: TextBoxComponent(
                    controller: _shopController,
                    textBoxProperty: TextBoxProperty(hintText: 'Shop Name'),
                  ),
                ),
                Text(
                  'GST No',
                  style: AppTextStyle.getFont14Style(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: TextBoxComponent(
                    controller: _gstController,
                    textBoxProperty: TextBoxProperty(hintText: 'GST No'),
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width / 2 - 22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'City',
                            style: AppTextStyle.getFont14Style(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 12.0),
                            child: TextBoxComponent(
                              controller: _cityController,
                              textBoxProperty: TextBoxProperty(
                                hintText: 'City',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width / 2 - 22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pincode',
                            style: AppTextStyle.getFont14Style(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 12.0),
                            child: TextBoxComponent(
                              controller: _pincodeController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              textBoxProperty: TextBoxProperty(
                                  hintText: 'Pincode',
                                  inputType: TextInputType.number),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  'Purchase quantity',
                  style: AppTextStyle.getFont14Style(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: ProductQuantityDropdownWidget(
                    onChange: (changedValue) {
                      setState(() {
                        selectedQty = changedValue;
                      });
                    },
                    qtyOptions: qtyOptions,
                    selectedQty: selectedQty,
                  ),
                ),
                const SizedBox(height: 20),
                isScreenLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ButtonControl(
                        onTap: _submit,
                        borderRadius: 14.0,
                        textPadding: const EdgeInsets.symmetric(vertical: 14.0),
                        buttonProperty: ButtonProperty(
                          backgroundColor: AppColor.primaryColor,
                          text: 'Submit',
                          textColor: Colors.white,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    AppHelper().showFullScreenLoader(context);
    if (pickedFile != null) {
      File imageFiles = File(pickedFile.path);
      try {
        final userId = await SharedPrefHelper.getUserId() ?? '';
        var response = await getIt<NetworkRepository>()
            .updateProfilePic(userId, imageFiles, imageFiles.path);
        uploadedImage = response["data"]["profilePicPath"];
        Navigator.pop(context);
        setState(() {});
      } catch (e) {
        Navigator.pop(context);
        CustomToast.showToast('Profile pic could not be updated!');
      }
    }
  }

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_nameController.text.isEmpty || _shopController.text.isEmpty) {
      CustomToast.showToast("Please fill all the the details!");
      return;
    }
    setState(() {
      isScreenLoading = true;
    });

    try {
      final networkRepo = getIt<NetworkRepository>();
      final userId = await SharedPrefHelper.getUserId();

      final request = {
        "userId": userId,
        "name": _nameController.text.trim(),
        "shopName": _shopController.text.trim(),
        "profilePicPath": "",
        "gstNo": _gstController.text.trim(),
        "city": _cityController.text.trim(),
        "pinCode": _pincodeController.text.trim(),
        "purchaseQty": selectedQty.toString(),
        "userType": "3"
      };

      var response = await networkRepo.updateProfileData(request);
      if (response["type"] == "success") {
        await SharedPrefHelper.setLoginFormRequiredAndNotFilled(false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const Dashboard()),
          (route) => false,
        );
      }
    } catch (e) {
    } finally {
      setState(() {
        isScreenLoading = false;
      });
    }
  }
}
