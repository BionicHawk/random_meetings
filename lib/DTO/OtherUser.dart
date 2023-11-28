class OtherUser {
  int id;
  String username;
  String? profilePic;

  OtherUser({required this.id, required this.username, this.profilePic});

  factory OtherUser.fromJson(Map<String, dynamic> user) => OtherUser(
      id: user["id"],
      username: user["username"],
      profilePic: user["profilePic"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "profilePic": profilePic
    };
  }

}
