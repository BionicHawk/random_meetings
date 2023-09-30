import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  final String description;
  final double height;
  const InformationWidget(
      {super.key, required this.description, this.height = 1.5});

  @override
  Widget build(BuildContext context) {
    return Text(description, style: TextStyle(height: height, fontSize: 16));
  }
}
