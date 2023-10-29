import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/classes/meet_point.dart';
import 'package:random_meetings/screens/home/components/meet_point_item.dart';

var points = [
  MeetPoint(name: "Reunión de Videojuegos", distance: 4.3),
  MeetPoint(name: "Reunión de Deportes", distance: 1.2),
  MeetPoint(name: "Reunión de Películas", distance: 2.1),
  MeetPoint(name: "Reunión de Anime", distance: 2.3),
  MeetPoint(name: "Reunión de Música", distance: 0.5),
  MeetPoint(name: "Reunión de Gastronomía", distance: 2.5),
];

const pinDropColor = Colors.red;

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  List<Widget> meetingPoints = List.empty(growable: true);

  List<MeetPoint> sortList(List<MeetPoint> elements) {
    bool error = true;
    List<MeetPoint> newList = elements;

    while (error) {
      for (int i = 0; i < newList.length - 1; i++) {
        var current = newList[i];
        var next = newList[i + 1];
        if (next.distance < current.distance) {
          newList[i] = next;
          newList[i + 1] = current;
        }
      }

      error = false;

      for (int i = 0; i < newList.length - 1; i++) {
        if (newList[i].distance > newList[i + 1].distance) error = true;
      }
    }

    return newList;
  }

  @override
  void initState() {
    List<MeetPoint> sortedPoints = sortList(points);

    for (var point in sortedPoints) {
      meetingPoints.add(
        MeetPointItem(
            iconColor: pinDropColor,
            pointName: point.name,
            distanceValue: point.distance),
      );
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const titlePadding = Padding(padding: EdgeInsets.symmetric(vertical: 5));

    ListView contentList = ListView(children: meetingPoints);

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
