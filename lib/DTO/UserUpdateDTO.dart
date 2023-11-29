class UserUpdate {
  int id;
  String username;
  String email;
  String? description;
  String profilePic;

  UserUpdate(
      {required this.id,
      required this.username,
      required this.email,
      required this.description,
      required this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "description": description,
      "profilePic": profilePic
    };
  }

}
