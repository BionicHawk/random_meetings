import 'package:random_meetings/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:random_meetings/screens/signup/signup_page.dart';
import 'package:random_meetings/Common/sign_button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFF1154);

    void goToLogin() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    void goToSignup() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupPage()));
    }

    const welcomeTitle = Text(
      "¡Bienvenido!",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );

    const welcomeText = Text(
      "Explora y conecta con personas que comparten tus intereses en Meetup",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: accentColor,
        fontSize: 15,
      ),
    );

    final signInButton = SignButton(
      outlined: false,
      buttonColor: accentColor,
      buttonName: "Iniciar Sesión",
      textColor: Colors.white,
      onPressed: goToLogin,
    );

    final signUpButton = SignButton(
      outlined: true,
      outlineColor: accentColor,
      textColor: Colors.black,
      buttonName: "Registrarse",
      onPressed: goToSignup,
    );

    final columnOfButtons = Column(
      children: [
        signInButton,
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        signUpButton,
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [
                  welcomeTitle,
                  SizedBox(
                    height: 20,
                  ),
                  welcomeText,
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login.jpeg"))),
              ),
              columnOfButtons,
            ],
          ),
        ),
      ),
    );
  }
}
