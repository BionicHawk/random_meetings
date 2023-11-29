class ProfileDTO {
  int id;
  String username;
  String? description;
  String? profilePic;

  ProfileDTO(
      {required this.id,
      required this.username,
      this.description,
      this.profilePic});

  factory ProfileDTO.fromJson(Map<String, dynamic> data) {
    return ProfileDTO(
        id: data["id"],
        username: data["username"],
        description: data["description"],
        profilePic: data["profilePic"]);
  }
}
