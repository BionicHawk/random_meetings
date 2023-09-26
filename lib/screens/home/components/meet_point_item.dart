import 'package:flutter/material.dart';

class MeetPointItem extends StatelessWidget {
  final double height;

  const MeetPointItem({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: height,
        child: const Placeholder(),
      ),
    );
  }
}
