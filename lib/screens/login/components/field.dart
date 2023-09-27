import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool discretText;
  final String? hintText;
  final IconData icon;
  final Color iconColor;
  final double? height;
  final double? width;
  final Color cursorColor;
  final Color textColor;
  final double? fontSize;
  final double? letterSpacing;

  const Field(
      {super.key,
      this.textEditingController,
      this.discretText = false,
      this.hintText,
      this.icon = Icons.abc,
      this.iconColor = Colors.grey,
      this.height,
      this.width,
      this.cursorColor = Colors.grey,
      this.textColor = Colors.black54,
      this.fontSize,
      this.letterSpacing});

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  void dispose() {
    if (widget.textEditingController != null) {
      widget.textEditingController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: widget.textColor,
        fontSize: widget.fontSize,
        letterSpacing: widget.letterSpacing);

    final inputDecoration = InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
        border: const OutlineInputBorder(),
        hintText: widget.hintText);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.textEditingController,
        obscureText: widget.discretText,
        cursorColor: widget.cursorColor,
        style: textStyle,
        decoration: inputDecoration,
      ),
    );
  }
}
