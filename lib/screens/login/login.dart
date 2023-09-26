import 'package:flutter/material.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/login/components/buttons.dart';
import 'components/field.dart';

Future<List> gatherData() async {
  final users = [
    {"username": "angel", "password": "1234"},
    {"username": "yamileth", "password": "4567"},
    {"username": "dante", "password": "qwer"},
    {"username": "emiliano", "password": "tyui"},
    {"username": "nelson", "password": "asdf"}
  ];

  return users;
}

class LoginScreen extends StatelessWidget {
  final userFieldController = TextEditingController();
  final passFieldController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* Aquí se mandarán las credenciales a la api, y la api
      devolverá el resultado, diciendo si el acceso es válido
      o no */
    Future<bool> validateCredentials(String username, String pass) async {
      final users = await gatherData();

      for (final user in users) {
        if (user["username"] == username && user["password"] == pass) {
          return true;
        }
      }
      // ignore: use_build_context_synchronously
      showErrorDialog(context, "Credenciales Incorrectas",
          "La contraseña o el nombre de usuario son incorrectos");
      return false;
    }

    /* Aquí es donde pasará a otra pantalla depués de un
      inicio de sesión exitoso */
    void signIn() async {
      bool success = await validateCredentials(
          userFieldController.text, passFieldController.text);

      if (!success) return;

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }

    /* En está parte se mandará al usuario a la pantalla
       de crear cuenta */
    void newAccount() {
      print("Creando cuenta");
    }

    final userField = Field(
      fieldName: "Usuario",
      textEditingController: userFieldController,
      hintText: "Ingrese su usuario",
    );

    final passwordField = Field(
      fieldName: "Contraseña",
      discretText: true,
      textEditingController: passFieldController,
      hintText: "Ingrese su contraseña",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 60)),
            userField,
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
            passwordField,
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10)),
            const Expanded(child: Column()),
            Buttons(
              userField: userFieldController,
              passField: passFieldController,
              signIn: signIn,
              signUp: newAccount,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          ],
        ),
      ),
    );
  }
}
