import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MeetingMap extends StatefulWidget {
  final String token;
  const MeetingMap({super.key, required this.token});

  @override
  State<MeetingMap> createState() => _MeetingMapState();
}

class _MeetingMapState extends State<MeetingMap> {
  @override
  Widget build(BuildContext context) {
    const myPositon = LatLng(25.725244367892014, -100.3142243727138);

    final options = MapOptions(
      center: myPositon,
      minZoom: 5,
      maxZoom: 25,
      zoom: 18,
    );

    final tileLayer = TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken': widget.token,
        'id': 'mapbox/streets-v12'
      },
    );

    Marker userMarker = Marker(
        point: myPositon,
        builder: (context) => const Icon(
              Icons.person_pin,
              color: Colors.blueAccent,
              size: 40,
            ));

    MarkerLayer mLayer = MarkerLayer(
      markers: [userMarker],
    );

    return FlutterMap(
      options: options,
      nonRotatedChildren: [tileLayer, mLayer],
    );
  }
}
