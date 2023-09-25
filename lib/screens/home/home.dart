import 'package:flutter/material.dart';
import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/profile/profile.dart';
import 'package:random_meetings/screens/settings/settings.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    void goToProfile() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Profile()));
    }

    void goToSettings() {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de reuniones"),
      ),
      body: Column(
        children: [
          const Expanded(child: Placeholder()),
          NavigationBarMap(
            goToProfile: goToProfile,
            goToSettings: goToSettings,
            userAtHome: true,
          ),
        ],
      ),
    );
  }
}
