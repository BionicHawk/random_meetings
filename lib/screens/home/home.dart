import 'package:flutter/material.dart';
import 'package:random_meetings/screens/home/components/bottom_sheet_content.dart';
import 'package:random_meetings/screens/home/components/meeting_map.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    "[USE YOUR TOKEN HERE]";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    void showCustomButtomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => const SizedBox(
                child: BottomSheetContent(),
              ));
    }

    final showBottomSheetButton = ElevatedButton(
        onPressed: showCustomButtomSheet,
        child: const Text("Mostrar puntos de reunión"));

    return Column(
      children: [
        Expanded(
            child: Stack(children: [
          const MeetingMap(token: MAPBOX_ACCESS_TOKEN),
          // const Placeholder(),
          Align(
            alignment: Alignment.bottomCenter,
            child: showBottomSheetButton,
          )
        ])),
      ],
    );
  }
}
