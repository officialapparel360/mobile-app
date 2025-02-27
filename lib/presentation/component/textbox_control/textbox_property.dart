import 'package:flutter/material.dart';

class TextBoxProperty {
  String label;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  TextInputType? inputType;
  int? maxLength;


  TextBoxProperty({
    required this.label,
    this.textStyle,
    this.hintStyle,
    this.inputType,
    this.maxLength,
  });
}
