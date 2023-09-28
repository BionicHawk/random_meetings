import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/components/meet_point_item.dart';

const points = [
  {
    "name": "Reunión de Videojuegos",
    "distance": 4.3
  },{
    "name": "Reunión de Deportes",
    "distance": 1.2
  },{
    "name": "Reunión de Películas",
    "distance": 2.1
  },{
    "name": "Reunión de Anime",
    "distance": 2.3
  },{
    "name": "Reunión de Música",
    "distance": 0.5
  },{
    "name": "Reunión de Gastronomía",
    "distance": 2.5
  },
];

const pinDropColor = Colors.red;

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  List<Widget> meetingPoints = List.empty(growable: true); 
  
  @override
  void initState() {
    for (var point in points) {
      meetingPoints.add(
	MeetPointItem(
	  iconColor: pinDropColor,
	  pointName: point["name"].toString(),
	  distanceValue: double.parse(point["distance"].toString()),
	)
      );
    }
    setState(() {
      
    });
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
