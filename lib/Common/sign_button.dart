import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String? buttonName;
  final Color textColor;
  final Color? buttonColor;
  final Color? outlineColor;
  final double fontSize;
  final double minWidth;
  final double height;
  final double borderRadius;
  final bool outlined;
  final VoidCallback? onPressed;

  const SignButton(
      {super.key,
      this.height = 60,
      this.buttonName,
      this.textColor = Colors.black,
      this.fontSize = 18,
      this.minWidth = double.infinity,
      this.borderRadius = 50,
      this.buttonColor,
      required this.outlined,
      this.outlineColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textButton = Text(
      buttonName ?? "No name",
      style: TextStyle(
          color: textColor, fontWeight: FontWeight.w600, fontSize: fontSize),
    );

    return MaterialButton(
      onPressed: onPressed,
      minWidth: minWidth,
      height: height,
      color: buttonColor,
      shape: RoundedRectangleBorder(
          side: outlined
              ? BorderSide(color: outlineColor ?? Colors.black)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: textButton,
    );
  }
}
