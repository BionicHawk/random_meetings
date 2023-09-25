import 'package:flutter/material.dart';
import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/profile/profile.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Column(children: [
        const Expanded(child: Placeholder()),
        NavigationBarMap(
          userAtSettings: true,
          goToHome: goToHome,
          goToProfile: goToProfile,
        )
      ]),
    );
  }
}
