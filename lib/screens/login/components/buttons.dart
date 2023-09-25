import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final TextEditingController? userField;
  final TextEditingController? passField;
  final VoidCallback? signIn;
  final VoidCallback? signUp;

  const Buttons(
      {super.key, this.userField, this.passField, this.signIn, this.signUp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.tonal(
            onPressed: signUp, child: const Text("Crear Cuenta")),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
        FilledButton(onPressed: signIn, child: const Text("Iniciar Sesión"))
      ],
    );
  }
}
