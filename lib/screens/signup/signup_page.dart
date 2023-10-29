import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/Common/sign_button.dart';
import 'package:random_meetings/DTO/InterestData.dart';
import 'package:random_meetings/screens/login/login.dart';
import 'package:dio/dio.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  List<InterestData> interests = List.empty(growable: true);

  Future<void> fetchInterest() async {
    Response<dynamic> data = await Dio().get(Connection.getApiUrlAllInterests());
    var rawData = data.data["data"];

    for (var raw in rawData) {
      interests.add(new InterestData.fromJson(raw));
    }

    // TODO

  }

  @override
  void initState() {
    super.initState();
    fetchInterest();
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFF1154);

    void goBack() => Navigator.pop(context);

    void goToLogin() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      onPressed: () {},
    );

    return Scaffold(
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
                  inputFile(label: "Usuario"),
                  inputFile(label: "Email"),
                  inputFile(label: "Contraseña", obscureText: true),
                  inputFile(label: "Confirma contraseña ", obscureText: true),
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
    );
  }
}

Widget inputFile({label, obscureText = false}) {
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
