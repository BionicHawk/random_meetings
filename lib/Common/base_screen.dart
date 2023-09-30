import 'package:flutter/material.dart';
import 'package:random_meetings/Common/navigation_bar.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/profile/profile.dart';
import 'package:random_meetings/screens/settings/settings.dart';

// const accentColor = Color(0xFFFF1154);
const accentColor = Color(0xFFFF1154);

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool atHome = true, atSettings = false, atProfile = false;

  final homeAppBar = AppBar(
    title: const Text("Mapa de reuniones"),
  );

  static const homePage = Home();

  final settingsAppBar = AppBar(title: const Text("Configuración"));

  static const settingsPage = SettingsScreen();

  final profileAppBar = AppBar(
    automaticallyImplyLeading: false, // Quitar la flecha de retroceso
    backgroundColor: accentColor, // Cambiar el color de fondo a rojo
    title: const Text(
      "Perfil",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );

  static const profilePage = Profile();

  AppBar? choosenAppBar;
  Widget? choosenWidget;

  void determineAppBar() {
    if (atHome) {
      choosenAppBar = homeAppBar;
      choosenWidget = homePage;
    }
    if (atProfile) {
      choosenAppBar = profileAppBar;
      choosenWidget = profilePage;
    }
    if (atSettings) {
      choosenAppBar = settingsAppBar;
      choosenWidget = settingsPage;
    }
  }

  void goToHome() {
    setState(() {
      atHome = true;
      atProfile = false;
      atSettings = false;
      determineAppBar();
    });
  }

  void goToSettings() {
    setState(() {
      atHome = false;
      atProfile = false;
      atSettings = true;
      determineAppBar();
    });
  }

  void goToProfile() {
    setState(() {
      atHome = false;
      atProfile = true;
      atSettings = false;
      determineAppBar();
    });
  }

  @override
  void initState() {
    determineAppBar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: choosenAppBar,
        body: Column(
          children: [
            Expanded(
                child: SizedBox(
              child: choosenWidget,
            )),
            NavigationBarMap(
                userAtHome: atHome,
                userAtProfile: atProfile,
                userAtSettings: atSettings,
                goToHome: goToHome,
                goToSettings: goToSettings,
                goToProfile: goToProfile)
          ],
        ));
  }
}
