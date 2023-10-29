import 'package:flutter/material.dart';

class NavigationBarMap extends StatelessWidget {
  final bool userAtProfile;
  final bool userAtHome;
  final bool userAtSettings;

  final VoidCallback? goToProfile;
  final VoidCallback? goToHome;
  final VoidCallback? goToSettings;

  const NavigationBarMap(
      {super.key,
      this.userAtHome = false,
      this.userAtProfile = false,
      this.userAtSettings = false,
      this.goToHome,
      this.goToProfile,
      this.goToSettings});

  @override
  Widget build(BuildContext context) {
    const double paddingValue = 12;

    const prefabPadding =
        Padding(padding: EdgeInsets.symmetric(horizontal: paddingValue));

    final profileBtn = NavBtn(
      icon: Icons.account_circle,
      onPressed: goToProfile,
      isUserHere: userAtProfile,
    );

    final homeBtn = NavBtn(
      icon: Icons.home,
      onPressed: goToHome,
      isUserHere: userAtHome,
    );

    final settingsBtn = NavBtn(
      icon: Icons.settings,
      onPressed: goToSettings,
      isUserHere: userAtSettings,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.075,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        profileBtn,
        prefabPadding,
        homeBtn,
        prefabPadding,
        settingsBtn,
      ]),
    );
  }
}

class NavBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isUserHere;

  const NavBtn({super.key, this.onPressed, this.icon, this.isUserHere = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        onPressed: !isUserHere ? onPressed ?? () {} : () {},
        style: FilledButton.styleFrom(
            backgroundColor: !isUserHere
                ? Theme.of(context).cardColor
                : Theme.of(context).focusColor),
        child: Icon(icon ?? Icons.no_photography));
  }
}
