import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_meetings/Common/app_communication_base.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/DTO/Comment.dart';
import 'package:random_meetings/DTO/MarkersIn.dart';
import 'package:random_meetings/DTO/OtherUser.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key, required this.markerData});

  final MarkerIn markerData;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  List<Comment>? comments;
  List<Message>? messages;
  TextEditingController commentController = TextEditingController();
  var message ="Cargando comentarios...";

  Future<void> fetchContent() async {
    comments = await AppCommunicationBase.getComments(widget.markerData.id);
    if (comments != null) {
      messages = List.empty(growable: true);
      for (var comment in comments!) {
        messages!.add(Message(data: comment));
      }
    } else {
    }
    message = "No hay comentarios";
    setState(() {});
  }

  void publishComment() async {
    if (commentController.text.isNotEmpty) {
      OtherUser fromThis = OtherUser(
          id: Connection.localUser!.id,
          username: Connection.localUser!.username,
          profilePic: Connection.localUser!.profilePic);
      print(fromThis.profilePic);
      Comment comment =
          Comment(id: 0, content: commentController.text, user: fromThis);

      await Dio().post(Connection.getApiCommentsUrl(widget.markerData.id),
          data: comment.toJson());
      commentController.text = "";
      await fetchContent();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Salón de ${widget.markerData.interest.name}#${widget.markerData.id}"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.grey,
                    child: ListView(children: messages ?? [Center(child: Text(message))]),
                  ))),
          Row(
            children: [
              Expanded(
                  child: MessageTextInput(
                controller: commentController,
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton.filledTonal(
                    onPressed: publishComment, icon: const Icon(Icons.send)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MessageTextInput extends StatelessWidget {
  const MessageTextInput({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Inserte un comentario...",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({super.key, required this.data});

  final Comment data;

  @override
  Widget build(BuildContext context) {
    final profilePic = ClipOval(
      child: SizedBox(width: 50, height: 50, child: Image.network(Connection.getApiProfileImage(data.user.profilePic!))),
    );

    return Card(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: profilePic,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  data.user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, top: 4, bottom: 4),
                child: Column(
                  children: [
                    Text(data.content),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4, right: 4),
                    child: Text(
                      data.postedAt ?? "No data",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
