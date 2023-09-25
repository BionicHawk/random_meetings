import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final String? fieldName;
  final TextEditingController? textEditingController;
  final bool discretText;
  final String? hintText;

  const Field(
      {super.key,
      this.fieldName,
      this.textEditingController,
      this.discretText = false,
      this.hintText});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.fieldName ?? "Campo", style: const TextStyle(fontSize: 18)),
        SizedBox(
          width: 200,
          height: 35,
          child: TextField(
            controller: widget.textEditingController,
            obscureText: widget.discretText,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                hintText: widget.hintText ?? ""),
          ),
        )
      ],
    );
  }
}
