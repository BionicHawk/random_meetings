import 'package:flutter/material.dart';

class InterestTile extends StatelessWidget {
  final double? height;
  final String interestValue;
  const InterestTile({super.key, this.height, required this.interestValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        child: Container(
          color: const Color(0xFFFF1154),
          padding: const EdgeInsets.all(8),
          child: Text(interestValue,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
