import 'package:flutter/material.dart';

import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/settings/settings.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    void goToHome() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }

    void goToSettings() {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tu perfil"),
      ),
      body: Column(
        children: [
          const Expanded(child: Placeholder()),
          NavigationBarMap(
            userAtProfile: true,
            goToHome: goToHome,
            goToSettings: goToSettings,
          )
        ],
      ),
    );
  }
}
