import 'package:flutter/material.dart';
import 'package:random_meetings/screens/welcome/welcome.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Retraso de 3 segundos antes de navegar a la pantalla principal.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Welcome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 255, 255, 255), // Fondo color blanco
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 350,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 130,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
