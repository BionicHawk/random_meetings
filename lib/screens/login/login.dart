import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/login/components/buttons.dart';
import 'components/field.dart';

final userFieldController = TextEditingController();
final passFieldController = TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    /* Aquí se mandarán las credenciales a la api, y la api
      devolverá el resultado, diciendo si el acceso es válido
      o no */
    Future<bool> validateCredentials(String user, String pass) async {
      return true;
    }

    /* Aquí es donde pasará a otra pantalla depués de un
      inicio de sesión exitoso */
    void signIn() async {
      bool success = await validateCredentials(
          userFieldController.text, passFieldController.text);

      if (!success) return;

      print(userFieldController.text);
      print(passFieldController.text);

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
