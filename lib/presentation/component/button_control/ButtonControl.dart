import 'package:flutter/material.dart';

import 'button_proprty.dart';


class ButtonControl extends StatefulWidget {
  ButtonControl({
    Key? key,
    required this.buttonProperty,
    required this.onTap,
    this.textPadding,
  }) : super(key: key);

  ButtonProperty buttonProperty;
  VoidCallback onTap;
  EdgeInsetsGeometry? textPadding;

  @override
  State<ButtonControl> createState() => _ButtonControlState();
}

class _ButtonControlState extends State<ButtonControl> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // widget.buttonProperty.buttonSize?.height != 0.0
      //      ? widget.buttonProperty.buttonSize?.height
      //      : null,
      width: widget.buttonProperty.buttonSize?.width,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.buttonProperty.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0))),
        child: Padding(
          padding: widget.textPadding ?? EdgeInsets.zero,
          child: Text(
            widget.buttonProperty.text ?? '',
            style: TextStyle(
              color: widget.buttonProperty.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
