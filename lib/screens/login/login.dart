import 'package:flutter/material.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'components/field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFieldController = TextEditingController();
    final passFieldController = TextEditingController();

    Future<bool> validateCredentials(String username, String password) async {
      final users = [
        {"username": "angel", "password": "1234"},
        {"username": "yamileth", "password": "4567"},
        {"username": "dante", "password": "qwer"},
        {"username": "emiliano", "password": "tyui"},
        {"username": "nelson", "password": "asdf"}
      ];

      for (final user in users) {
        if (user["username"] == username && user["password"] == password) {
          return true;
        }
      }

      return false;
    }

    void signIn(BuildContext context) async {
      bool success = await validateCredentials(
          userFieldController.text, passFieldController.text);

      if (!success) {
        // ignore: use_build_context_synchronously
        showErrorDialog(context, "Error en el inicio de sesión",
            "La contraseña o el nombre de usuario son incorrectos");

        return;
      }

      // Código para actualizar las credenciales (por ejemplo, guardar en SharedPreferences)
      // Debes implementar esta lógica según tus necesidades

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }

    void newAccount() {
      // Lógica para crear una cuenta
      print("Creando cuenta");
    }

    const normalSpacer = Padding(padding: EdgeInsets.symmetric(vertical: 10));
    const accentColor = Color(0xffff4590);
    const secondaryColorText = Colors.black54;

    final mainTitle = RichText(
      text: const TextSpan(
        text: 'Conoce',
        style: TextStyle(
          fontSize: 32,
          color: accentColor,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' y crea planes',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );

    final userInput = Field(
      hintText: "Nombre de usuario",
      icon: Icons.person_outline,
      textEditingController: userFieldController,
      textColor: secondaryColorText,
    );

    final passField = Field(
      discretText: true,
      hintText: "Contraseña",
      textEditingController: passFieldController,
      fontSize: 20,
      letterSpacing: 1.4,
      icon: Icons.lock_outline,
      textColor: secondaryColorText,
    );

    const fieldsSectionTitle = Text(
      "Inicia Sesión",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );

    final signInButton = ElevatedButton(
        onPressed: () => signIn(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
        ),
        child: const Text(
          "Iniciar Sesión",
          style: TextStyle(color: Colors.white),
        ));

    final newAccountButton = TextButton(
        onPressed: newAccount,
        child: const Text(
          "Crear una cuenta",
          style: TextStyle(color: secondaryColorText),
        ));

    final groupOfFields = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        fieldsSectionTitle,
        normalSpacer,
        userInput,
        normalSpacer,
        passField,
        normalSpacer,
        signInButton,
        newAccountButton
      ],
    );

    final fieldsContainerDecoration = BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          spreadRadius: 2,
          blurRadius: 20,
          offset: Offset(0, 0),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: mainTitle,
                ),
                SizedBox(
                  child: Image.asset('assets/login.jpeg', width: 220),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: fieldsContainerDecoration,
                    child: groupOfFields),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
