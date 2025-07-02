import 'package:apparel_360/core/app_style/app_color.dart';
import 'package:apparel_360/presentation/component/textbox_control/textbox_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/app_style/app_callback.dart';

class TextBoxComponent extends StatelessWidget {
  const TextBoxComponent(
      {super.key,
      this.onChanged,
      this.textBoxProperty,
      this.inputFormatters,
      this.borderRadius = 14.0,
      this.controller});

  final StringToVoidCallBack? onChanged;
  final TextBoxProperty? textBoxProperty;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: textBoxProperty?.inputType,
      maxLength: textBoxProperty?.maxLength,
      inputFormatters: inputFormatters,
      style: textBoxProperty?.textStyle,

      decoration: InputDecoration(
        hintText: textBoxProperty?.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColor.black400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColor.black400),
        ),
        hintStyle: textBoxProperty?.hintStyle,
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.only(left: 18.0, right: 24.0, top: 0.0),
      ),
    );
  }
}
