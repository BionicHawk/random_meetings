import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/components/meet_point_item.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    const titlePadding = Padding(padding: EdgeInsets.symmetric(vertical: 5));

    ListView contentList = ListView(
      children: const [
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
        MeetPointItem(),
      ],
    );

    const title = Column(
      children: [
        titlePadding,
        Text(
          "Reuniones Cercanas",
          style: TextStyle(fontSize: 20),
        ),
        titlePadding
      ],
    );
    return Column(
      children: [title, const Divider(), Expanded(child: contentList)],
    );
  }
}
