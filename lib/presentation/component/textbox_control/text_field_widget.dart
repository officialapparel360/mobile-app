import 'package:apparel_360/presentation/component/textbox_control/textbox_property.dart';
import 'package:flutter/material.dart';
import '../../../core/app_style/app_callback.dart';

class TextBoxComponent extends StatelessWidget {
  const TextBoxComponent({super.key, this.onChanged, this.textBoxProperty});

  final StringToVoidCallBack? onChanged;
  final TextBoxProperty? textBoxProperty;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: textBoxProperty?.inputType,
      maxLength: textBoxProperty?.maxLength,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.blue)),
        filled: true,
        contentPadding:
            const EdgeInsets.only(bottom: 18.0, left: 18.0, right: 24.0),
        labelText: textBoxProperty?.label,
      ),
    );
  }
}
