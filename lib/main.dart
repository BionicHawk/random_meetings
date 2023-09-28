import 'package:flutter/material.dart';
import 'package:random_meetings/screens/splash/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetup - Conoce y crea planes',
      theme: ThemeData(useMaterial3: true),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
