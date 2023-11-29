// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/Common/dialogs.dart';
import 'package:random_meetings/DTO/UserUpdateDTO.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static TextEditingController imageUrl = TextEditingController();
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    imageUrl.text = Connection.localUser!.profilePic ?? "";
    usernameController.text = Connection.localUser!.username;
    descriptionController.text = Connection.localUser!.description ?? "";

    void updateProfile() async {
      if (imageUrl.text.isNotEmpty && usernameController.text.isNotEmpty) {
        final currentUser = Connection.localUser!;
        UserUpdate updated = UserUpdate(
            id: currentUser.id,
            username: usernameController.text,
            email: currentUser.email,
            description: descriptionController.text,
            profilePic: imageUrl.text);

        final res = await Dio().put(Connection.getUpdateUserUrl(currentUser.id), data: updated.toJson());
        if (res.statusCode! < 400) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          return;
        }
        showErrorDialog(context, "Hubo un error", "La información proporcionada puede no ser valida");

      } else {
        showErrorDialog(context, "Datos invalidos",
            "El campo de foto de perfil o nombre de usuario están vacíos");
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Editar perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EditAttr(
                labelAttributeName: "Link de foto perfil",
                controller: imageUrl),
            EditAttr(
              labelAttributeName: "Nombre de usuario",
              controller: usernameController,
            ),
            EditAttr(
              labelAttributeName: "Descripción",
              controller: descriptionController,
              longText: true,
            ),
            const Expanded(child: Column()),
            SendButton(
              asyncAction: updateProfile,
            )
          ],
        ),
      ),
    );
  }
}

class EditAttr extends StatelessWidget {
  const EditAttr(
      {super.key,
      required this.labelAttributeName,
      required this.controller,
      this.longText = false});

  final String labelAttributeName;
  final TextEditingController controller;
  final bool longText;

  @override
  Widget build(BuildContext context) {
    final label = TextField(
      controller: controller,
      minLines: longText ? 3 : 1,
      maxLines: longText ? 3 : 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelAttributeName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        label
      ],
    );
  }
}

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.asyncAction});

  final VoidCallback asyncAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: FilledButton(
            onPressed: asyncAction,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Enviar cambios",
                style: TextStyle(fontSize: 20),
              ),
            )));
  }
}
