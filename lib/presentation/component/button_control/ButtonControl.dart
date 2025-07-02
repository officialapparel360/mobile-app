import 'package:flutter/material.dart';

import 'button_proprty.dart';

class ButtonControl extends StatelessWidget {
  const ButtonControl(
      {super.key,
      required this.buttonProperty,
      required this.onTap,
      this.textPadding,
      this.borderRadius = 20.0});

  final ButtonProperty buttonProperty;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? textPadding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonProperty.buttonSize?.width,
      height: buttonProperty.buttonSize?.height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonProperty.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
        child: Padding(
          padding: textPadding ?? EdgeInsets.zero,
          child: Text(
            buttonProperty.text ?? '',
            style: TextStyle(color: buttonProperty.textColor, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
