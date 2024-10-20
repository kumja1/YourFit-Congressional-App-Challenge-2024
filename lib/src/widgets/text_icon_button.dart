import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final IconData? icon;

  final String text;

  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  // ignore: prefer_function_declarations_over_variables
  final Function() onPressed;

  TextIconButton(this.text,
      {this.icon, this.buttonStyle, this.textStyle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(
        text,
        style: textStyle,
      ),
      style: buttonStyle,
      icon: Icon(icon),
      
    );
  }
}
