import 'package:flutter/material.dart';

class TextBoxProperty {
  TextStyle? textStyle;
  TextStyle? hintStyle;
  TextInputType? inputType;
  int? maxLength;
  String? hintText;

  TextBoxProperty(
      {this.textStyle,
      this.hintStyle,
      this.inputType,
      this.maxLength,
      this.hintText});
}
