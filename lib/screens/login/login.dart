import 'package:flutter/material.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/login/components/buttons.dart';
import 'components/field.dart';

final userFieldController = TextEditingController();
final passFieldController = TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
    bool success =
        await validateCredentials(userFieldController.text, passFieldController.text);

    if (!success) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('La contraseña o el nombre de usuario son incorrectos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Código para actualizar las credenciales (por ejemplo, guardar en SharedPreferences)
    // Debes implementar esta lógica según tus necesidades

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void newAccount() {
    // Lógica para crear una cuenta
    print("Creando cuenta");
  }

  @override
  Widget build(BuildContext context) {
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
                  child: RichText(
                    text: const TextSpan(
                      text: 'Conoce',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xffff4590),
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
                  ),
                ),
                SizedBox(
                  child: Image.asset('assets/login.jpeg'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Inicia sesión',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: userFieldController,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          hintText: 'Nombre de usuario',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passFieldController,
                        obscureText: true,
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          letterSpacing: 1.4,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => signIn(context), // Llama a la función signIn
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffff4590),
                        ),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: newAccount, // Llama a la función newAccount
                        child: Text(
                          'Crear una cuenta',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
