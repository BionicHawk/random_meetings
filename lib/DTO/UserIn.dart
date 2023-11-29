class UserIn {
  final int id;
  final String username;
  final String email;
  final String? description;
  final String? profilePic;
  final String createdAt;

  const UserIn(
      {required this.id,
      required this.username,
      required this.email,
      this.description,
      this.profilePic,
      required this.createdAt});

  factory UserIn.fromJson(Map<String, dynamic> user) => UserIn(
    id: user["id"],
    username: user["username"],
    email: user["email"],
    description: user["description"],
    profilePic: user["profilePic"],
    createdAt: user["createdAt"]
  );

}
