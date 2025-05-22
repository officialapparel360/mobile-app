import 'package:apparel_360/presentation/component/textbox_control/textbox_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/app_style/app_callback.dart';

class TextBoxComponent extends StatelessWidget {
  const TextBoxComponent(
      {super.key, this.onChanged, this.textBoxProperty, this.inputFormatters});

  final StringToVoidCallBack? onChanged;
  final TextBoxProperty? textBoxProperty;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: textBoxProperty?.inputType,
      maxLength: textBoxProperty?.maxLength,
      inputFormatters: inputFormatters,
      style: textBoxProperty?.textStyle,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.only(left: 18.0, right: 24.0, bottom: 14.0),
        labelText: textBoxProperty?.label,
      ),
    );
  }
}
