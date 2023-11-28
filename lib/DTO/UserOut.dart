import 'package:random_meetings/DTO/InterestData.dart';
import 'dart:convert';

class UserForm {
  final String username;
  final String email;
  final String password;
  final String confirmedPass;

  const UserForm(
      {required this.username,
        required this.email,
        required this.password,
        required this.confirmedPass,});

}

class UserOut {
  final String username;
  final String email;
  final String password;
  final String? description;
  final String? profilePic;

  const UserOut(
      {required this.username,
      required this.email,
      required this.password,
      this.description,
      this.profilePic});

  factory UserOut.fromForm(UserForm user) => UserOut(
    username: user.username,
    password: user.password,
    email: user.email,
  );

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "description": description,
      "profilePic": profilePic,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }

}


