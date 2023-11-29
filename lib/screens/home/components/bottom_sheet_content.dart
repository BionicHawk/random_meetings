import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/DTO/MarkersIn.dart';
import 'package:random_meetings/screens/home/classes/meet_point.dart';
import 'package:random_meetings/screens/home/components/meet_point_item.dart';

const pinDropColor = Colors.red;

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  List<Widget> meetingPoints = List.empty(growable: true);
  List<MarkerIn> markersData = List.empty(growable: true);

  double resolveDistance(double x, double y) {
    x *= pow(10.0, -4.0);
    y *= pow(10.0, -4.0);
    double uX = Connection.userX * pow(10.0, -4.0);
    double uY = Connection.userY * pow(10.0, -4.0);
    if (x < 0.0) x *= -1;
    if (y < 0.0) y *= -1;
    if (uX < 0.0) uX *= -1;
    if (uY < 0.0) uY *= -1;

    return sqrt(pow(uX - x, 2.0) + pow(uY - y, 2.0));
  }

  List<MarkerIn> sortList() {
    bool error = true;
    List<MarkerIn> newList = Connection.markersIns;

    while (error) {
      for (int i = 0; i < newList.length - 1; i++) {
        var current = newList[i];
        var next = newList[i + 1];
        var currentDistance = resolveDistance(current.x, current.y);
        var nextDistance = resolveDistance(next.x, next.y);

        if (nextDistance < currentDistance) {
          newList[i] = next;
          newList[i + 1] = current;
        }
      }

      error = false;

      for (int i = 0; i < newList.length - 1; i++) {
        var currentDistance = resolveDistance(newList[i].x, newList[i].y);
        var nextDistance = resolveDistance(newList[i + 1].x, newList[i + 1].y);
        if (currentDistance > nextDistance) error = true;
      }
    }

    return newList;
  }

  void setPoints() {
    List<MarkerIn> sortedPoints = sortList();
    sortedPoints;
    setState(() {
      for (var point in sortedPoints) {
        meetingPoints.add(MeetPointItem(
          markerIn: point,
          iconColor: pinDropColor,
          pointName: "Reunión ${point.interest.name} #${point.id}",
          distanceValue: resolveDistance(point.x, point.y),
        ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setPoints();
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
