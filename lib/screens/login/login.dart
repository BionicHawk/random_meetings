import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/home.dart';
import 'package:random_meetings/screens/signin/signout.dart';
// import 'package:diseno_app/screens/login/components/buttons.dart';  CHECAR SI AUN LOS NECESITAS
// import 'components/field.dart';  CHECAR SI AUN LOS NECESITAS 
final userFieldController = TextEditingController();
final passFieldController = TextEditingController();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Inciar sesión",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Ingresa a tu cuenta",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            inputFile(label: "Usuario"),
                            inputFile(label: "Contraseña", obscureText: true)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () => signIn(context),
                            color: Color(0xFFFF1154),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "INICIAR SESIÓN",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("¿Todavía no tienes cuenta?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignupPage()));
                              },
                              child: Text(
                                "Regístrate",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 17, 84), 
                                ),
                              ),
                            )
                          ],
                        ),
                      Container(
                        padding: EdgeInsets.only(top: 100),
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/singup.jpg"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para el campo de texto
  Widget inputFile({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: label == "Usuario" ? userFieldController : (label == "Contraseña" ? passFieldController : null),
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  void signIn(BuildContext context) async {
    final String username = userFieldController.text;
    final String password = passFieldController.text;

    bool success = await validateCredentials(username, password);

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
      } else {
    // si la credencia correcta
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()), // nos llevara a home
    );
  }
}

  }

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

