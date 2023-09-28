import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MeetPointItem extends StatelessWidget {
  final double height;
  final String? pointName;
  final double spacerValue;
  final double distanceValue;
  final IconData icon;
  final Color? iconColor;
  
  const MeetPointItem({super.key, 
  this.height = 80, 
  this.pointName, 
  this.spacerValue = 10, 
  this.distanceValue = 0.0,
  this.icon = Icons.pin_drop,
  this.iconColor});

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: spacerValue,);
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final iconWidget = Icon(
      icon,
      color: iconColor,
    );

    final name = Text(
      pointName ?? "No name", 
      style: textStyle,
    );

    const filler = Expanded(child: SizedBox(),);
    Text distance = Text(
      "${round(distanceValue, decimals: 2)} km", 
      style: textStyle,
    );

    return InkWell(
      onTap: () {},
      child: SizedBox(
        height: height,
        child: Row(
	  children: [
	    spacer,
	    iconWidget,
	    spacer,
	    name,
	    filler,
	    distance,
	    spacer
	  ],
	),
      ),
    );
  }
}
