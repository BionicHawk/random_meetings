import 'package:flutter/material.dart';
import 'screens/welcome/welcome.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meetup - Conocer y crea planes',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: Welcome(),
    );
  }
}
