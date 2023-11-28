import 'package:flutter/material.dart';
import 'package:random_meetings/Common/app_communication_base.dart';
import 'package:random_meetings/Common/base_screen.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/screens/login/components/field.dart';
import 'package:random_meetings/screens/signup/signup_page.dart';

// import 'package:diseno_app/screens/login/components/buttons.dart';  CHECAR SI AUN LOS NECESITAS
// import 'components/field.dart';  CHECAR SI AUN LOS NECESITAS

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final userFieldController = TextEditingController();
  static final passFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFF1154);

    Future<bool> validateCredentials(String username, String password) async {
      ValidationType vType = await AppCommunicationBase.tryLogin(username, password);
      if (vType == ValidationType.succesful) return true;
      return false;
    }

    void signIn(BuildContext context) async {
      final String username = userFieldController.text;
      final String password = passFieldController.text;

      bool success = await validateCredentials(username, password);

      if (!success) {
        // ignore: use_build_context_synchronously
        showErrorDialog(context, "Error de inicio de sesión",
            "La contraseña o el nombre de usuario son incorrectos");
      } else {
        // si la credencia correcta
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BaseScreen()),
        );
      }
    }

    final userField = Field(
      hintText: "Usuario",
      icon: Icons.person_outline,
      iconColor: accentColor,
      textEditingController: userFieldController,
      action: TextInputAction.next,
    );

    final passField = Field(
      hintText: "Contraseña",
      icon: Icons.lock_outline,
      iconColor: accentColor,
      discretText: true,
      textEditingController: passFieldController,
      action: TextInputAction.done,
      onSubmit: () {
        signIn(context);
      },
    );

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
          icon: const Icon(
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
                          const Text(
                            "Inciar sesión",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
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
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            userField,
                            const SizedBox(
                              height: 10,
                            ),
                            passField
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () => signIn(context),
                            color: const Color(0xFFFF1154),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
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
                          const Text("¿Todavía no tienes cuenta?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const SignupPage()));
                            },
                            child: const Text(
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
                        padding: const EdgeInsets.only(top: 100),
                        height: 200,
                        decoration: const BoxDecoration(
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
}
