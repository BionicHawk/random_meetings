// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_meetings/Common/HardCodedData/fake_interests.dart';
import 'package:random_meetings/Common/Interests/interest_box.dart';
import 'package:random_meetings/Common/app_communication_base.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/Common/sign_button.dart';
import 'package:random_meetings/DTO/InterestData.dart';
import 'package:random_meetings/DTO/UserOut.dart';
import 'package:random_meetings/screens/login/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<InterestData> interests = List.empty(growable: true);
  bool gotInterests = false;
  bool internetIssue = false;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmedPassController = TextEditingController();

  Future<void> fetchInterests() async {
    final previewInterests = await AppCommunicationBase.getAllInterests();

    if (previewInterests != null) {
      gotInterests = true;
      interests.addAll(previewInterests);
    } else {
      gotInterests = false;
      internetIssue = AppCommunicationBase.isAnInternetIssue();
    }

    setState(() {});
    // TODO
  }

  @override
  void initState() {
    super.initState();
    fetchInterests();
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFF1154);

    void goBack() => Navigator.pop(context);

    void goToLogin() {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    final leading = IconButton(
        onPressed: goBack,
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ));

    const title = Text(
      "Regístrate",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );

    const interestSelectorTitle = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "¡Seleccione sus intereses!",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    const commonPadding = SizedBox(
      height: 20,
    );

    final subTitle = Text(
      "¿Es tu primera vez en Meetup?",
      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
    );

    final newAccountButton = SignButton(
      outlined: false,
      buttonName: "Crear cuenta",
      buttonColor: accentColor,
      textColor: Colors.white,
      onPressed: () async {
        var action = await AppCommunicationBase.trySendNewUser(UserForm(
            username: userController.text,
            email: emailController.text,
            password: passController.text,
            confirmedPass: confirmedPassController.text));

        switch (action) {
          case ValidationType.notMatchingPass:
            showErrorDialog(context, "Contraseña invalida",
                "Las contraseñas que has puesto no coinciden");
            break;
          case ValidationType.notValidEmail:
            showErrorDialog(context, "Correo invalido",
                "El correo que proporcionaste no es válido");
            break;
          case ValidationType.serverOrInternetError:
            showErrorDialog(context, "No se pudo establecer una conexión",
                "No se pudo establecer conexión con el servidor, revisa tu conexión a internet");
            break;
          case ValidationType.succesful:
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            break;
          case ValidationType.notValidUsername:
            showErrorDialog(context, "Nombre de usuario invalido",
                "El usuario que proporcionaste es invalido");
            break;
          case ValidationType.invalidCredentials:
            showErrorDialog(context, "Credenciales invalidas",
                "Las credenciales que proporcionaste son invalidas");
            break;
        }
      },
    );

    return !internetIssue
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: leading,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        title,
                        commonPadding,
                        subTitle,
                        commonPadding,
                        inputFile(label: "Usuario", controller: userController),
                        inputFile(label: "Email", controller: emailController),
                        inputFile(
                            label: "Contraseña",
                            obscureText: true,
                            controller: passController),
                        inputFile(
                            label: "Confirma contraseña ",
                            obscureText: true,
                            controller: confirmedPassController),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        child: newAccountButton),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("¿Ya tienes una cuenta? "),
                        GestureDetector(
                          onTap: goToLogin,
                          child: const Text(
                            "Inicia sesion",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: accentColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Placeholder();
  }
}

Widget inputFile(
    {label, obscureText = false, TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
