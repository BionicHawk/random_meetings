import 'package:random_meetings/DTO/Comment.dart';
import 'package:random_meetings/DTO/InterestData.dart';
import 'package:random_meetings/DTO/OtherUser.dart';

class Room {

  int id;
  InterestData interest;
  List<Comment> comments;

  Room({required this.id, required this.interest, required this.comments});

  factory Room.fromJson(Map<String, dynamic> room) {
    List<Comment> previewedComments = List.empty(growable: true);

    for (var comment in room["comments"]) {
      var user = OtherUser.fromJson(comment["user"]);
      previewedComments.add(Comment(id: comment["id"], content: comment["content"], user: user));
    }

    return Room(
      id: room["id"],
      interest: room["interest"],
      comments: previewedComments
    );
  }

}