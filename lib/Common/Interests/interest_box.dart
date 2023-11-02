import 'package:flutter/material.dart';
import 'package:random_meetings/Common/Interests/interest_tile.dart';
import 'package:random_meetings/DTO/InterestData.dart';

class InterestBox extends StatefulWidget {
  final List<InterestData>? interests;
  const InterestBox({super.key, required this.interests});

  @override
  State<InterestBox> createState() => _InterestBoxState();
}

class _InterestBoxState extends State<InterestBox> {
  static List<Widget> interestsWidget = [];
  static List<Row> rows = [];

  @override
  void initState() {
    interestsWidget = [];
    List<Widget> temporaryRow = [];
    rows = [];

    if (widget.interests != null) {
      for (InterestData interest in widget.interests!) {
        interestsWidget.add(InterestTile(
          interest: interest,
        ));
      }
    }

    for (int i = 0; i < interestsWidget.length; i++) {
      temporaryRow.add(interestsWidget[i]);
      if (temporaryRow.length == 3) {
        rows.add(Row(
          children: temporaryRow,
        ));
        temporaryRow = [];
      }
    }
    if (temporaryRow.length % 3 != 0) {
      rows.add(Row(
        children: temporaryRow,
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return interestsWidget.isNotEmpty
        ? Column(
            children: rows,
          )
        : const Center(child: Text("No hay intereses por mostrar"));
  }
}
