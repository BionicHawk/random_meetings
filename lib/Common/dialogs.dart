import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, String message) async {
  final okButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Ok"));

  AlertDialog alert = AlertDialog(
    title: Text("🛑 $title"),
    content: Text(message),
    actions: [okButton],
  );

  showDialog(context: context, builder: (BuildContext context) => alert);
}

void showWarningDialog(
    BuildContext context,
    String title,
    String message,
    String okButtonName,
    VoidCallback? okFunction,
    VoidCallback? cancelFunction) {
  final okButton = TextButton(
      onPressed: () {
        okButtonName;
        print("Ok function has been done!");
        Navigator.pop(context, true);
      },
      child: Text(okButtonName));

  final cancelButton = TextButton(
      onPressed: () {
        cancelFunction;
        print("cancel function has been done!");
        Navigator.pop(context, false);
      },
      child: const Text("Cancelar"));

  AlertDialog alert = AlertDialog(
    title: Text("⚠ $title"),
    content: Text(message),
    actions: [cancelButton, okButton],
  );

  showDialog(context: context, builder: (BuildContext context) => alert);
}
