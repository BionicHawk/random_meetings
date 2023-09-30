import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String srcImage;
  const ProfilePicture(
      {super.key,
      this.height = 250,
      this.width = 600,
      this.borderRadius = 8,
      required this.srcImage});

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      srcImage,
      fit: BoxFit.cover,
    );

    final clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );

    return SizedBox(
      width: width,
      height: height,
      child: clipRRect,
    );
  }
}
