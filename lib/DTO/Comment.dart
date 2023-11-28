import 'package:random_meetings/DTO/OtherUser.dart';

class Comment {
  int id;
  String content;
  OtherUser user;
  String? postedAt;

  Comment(
      {required this.id,
      required this.content,
      required this.user,
      this.postedAt});

  factory Comment.fromJson(Map<String, dynamic> comment) => Comment(
    id: comment["id"],
    content: comment["content"],
    user: OtherUser.fromJson(comment["user"]),
    postedAt: comment["postedAt"]
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "user": user.toJson(),
      "postedAt": postedAt
    };
  }

}
