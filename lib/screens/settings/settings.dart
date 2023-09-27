import 'package:flutter/material.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/login/login.dart';
import 'package:random_meetings/screens/profile/profile.dart';
import 'package:random_meetings/screens/settings/components/section_conf.dart';
import 'package:random_meetings/screens/settings/components/setting.dart';
import 'package:random_meetings/screens/settings/components/setting_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToHome() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }

    void goToProfile() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    }

    void signOut() {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
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

    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Column(children: [
        Expanded(
            child: Column(
          children: [
            const SectionConf(
              sectionName: "Cuenta",
            ),
            const SettingLabel(),
            signOutWidget
          ],
        )),
        NavigationBarMap(
          userAtSettings: true,
          goToHome: goToHome,
          goToProfile: goToProfile,
        )
      ]),
    );
  }
}
