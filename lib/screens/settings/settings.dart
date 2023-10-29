import 'package:flutter/material.dart';
import 'package:random_meetings/screens/settings/components/section_conf.dart';
import 'package:random_meetings/screens/settings/components/setting.dart';
import 'package:random_meetings/screens/settings/components/setting_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      Navigator.pop(context);
    }

    final signOutWidget = SettingButton(
      icon: Icons.exit_to_app,
      iconColor: Colors.red.shade900,
      labelName: "Cerrar Sesión",
      onTap: () {
        //   showWarningDialog(context, "Cerrando Sesión",
        //       "¿Estás seguro o segura de querer cerrar sesión?", "Sí", () {
        //     signOut();
        //   }, () {});
        signOut();
      },
    );

    return Column(
      children: [
        const SectionConf(
          sectionName: "Cuenta",
        ),
        const SettingLabel(),
        signOutWidget
      ],
    );
  }
}
