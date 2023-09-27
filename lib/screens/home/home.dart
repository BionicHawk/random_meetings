import 'package:flutter/material.dart';
import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/components/bottom_sheet_content.dart';
import 'package:random_meetings/screens/home/components/meeting_map.dart';
import 'package:random_meetings/screens/profile/profile.dart';
import 'package:random_meetings/screens/settings/settings.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    "pk.eyJ1IjoiYmlvbmljaGF3ayIsImEiOiJjbG4yYno5enowNmt5Mndxd2Ftdzc2eWx1In0.ynLPGgH8j1UutdQLHwKSwQ";

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

    void showCustomButtomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => const SizedBox(
                child: BottomSheetContent(),
              ));
    }

    final showBottomSheetButton = ElevatedButton(
        onPressed: showCustomButtomSheet,
        child: const Text("Mostrar puntos de reunión"));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de reuniones"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(children: [
            const MeetingMap(token: MAPBOX_ACCESS_TOKEN),
            Align(
              alignment: Alignment.bottomCenter,
              child: showBottomSheetButton,
            )
          ])),
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
