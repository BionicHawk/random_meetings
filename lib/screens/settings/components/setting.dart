import 'package:flutter/material.dart';

bool light = true;

class SettingLabel extends StatelessWidget {
  final double height;
  final IconData? icon;
  final String labelName;

  const SettingLabel(
      {super.key, this.height = 50, this.icon, this.labelName = "Setting"});

  static var toggle = const SwitchSetting();

  @override
  Widget build(BuildContext context) {
    const normalPadding = Padding(padding: EdgeInsets.symmetric(horizontal: 5));

    final iconWidget = Icon(
      icon ?? Icons.settings,
      size: height * 0.6,
    );

    final label = Text(
      labelName,
      style: TextStyle(fontSize: height * 0.4),
    );

    const spacer = Expanded(
      child: SizedBox(),
    );

    return SizedBox(
      height: height,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        normalPadding,
        iconWidget,
        normalPadding,
        label,
        spacer,
        toggle,
        normalPadding
      ]),
    );
  }
}

class SwitchSetting extends StatefulWidget {
  final bool defaultEngaged;
  final VoidCallback? whenEngaged;
  final VoidCallback? whenOff;
  const SwitchSetting(
      {super.key, this.defaultEngaged = false, this.whenEngaged, this.whenOff});

  @override
  State<SwitchSetting> createState() => _SwitchSettingState();
}

class _SwitchSettingState extends State<SwitchSetting> {
  bool switchOn = false;
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      switchOn = widget.defaultEngaged;
      super.initState();
    }

    return Switch(
        value: switchOn,
        onChanged: (bool value) {
          if (value) {
            widget.whenEngaged;
          } else {
            widget.whenOff;
          }
          setState(() {
            switchOn = value;
          });
        });
  }
}
