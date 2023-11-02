import 'package:random_meetings/DTO/InterestData.dart';
import 'dart:convert';

class UserOut {
  final String username;
  final String email;
  final String password;
  final String? description;
  final List<InterestData> interests;
  final String? profilePic;

  const UserOut(
      {required this.username,
      required this.email,
      required this.password,
      this.description,
      required this.interests,
      this.profilePic});

  Map<String, dynamic> toJson() {

    List<Map<String, dynamic>> interestsMap = List.empty(growable: true);

    for (InterestData interest in interests) {
      interestsMap.add(interest.toJson());
    }

    return {
      "username": username,
      "email": email,
      "password": password,
      "description": description,
      "interests": interestsMap,
      "profilePic": profilePic,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }

}


