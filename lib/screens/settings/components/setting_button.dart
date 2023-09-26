import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final double height;
  final IconData? icon;
  final String labelName;
  final Color iconColor;
  final VoidCallback? onTap;

  const SettingButton(
      {super.key,
      this.height = 50,
      this.icon,
      this.labelName = "Setting",
      this.iconColor = Colors.black,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    const mainPadding = Padding(padding: EdgeInsets.symmetric(horizontal: 5));

    final iconWidget = Icon(
      icon ?? Icons.settings,
      size: height * 0.6,
      color: iconColor,
    );

    final labelWidget = Text(
      labelName,
      style: TextStyle(fontSize: height * 0.4),
    );

    return Card(
        child: InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          mainPadding,
          iconWidget,
          mainPadding,
          labelWidget,
        ]),
      ),
    ));
  }
}
