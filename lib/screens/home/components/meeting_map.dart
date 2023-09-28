import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MeetingMap extends StatefulWidget {
  final String token;
  const MeetingMap({super.key, required this.token});

  @override
  State<MeetingMap> createState() => _MeetingMapState();
}

class _MeetingMapState extends State<MeetingMap> {
  LatLng? myPositon;
  late StreamSubscription<Position> _streamSubscription;

  Future<void> startPositionStream(Function(Position)? callback) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      while (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    _streamSubscription = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation))
        .listen(callback);
  }

  Future<void> stopPositionStream() async {
    await _streamSubscription.cancel();
  }

  void _handlerPositionStream(Position? position) {
    setState(() {
      if (position != null) {
        myPositon = LatLng(position.latitude, position.longitude);
      }
    });
  }

  @override
  void initState() {
    startPositionStream(_handlerPositionStream);
    super.initState();
  }

  @override
  void dispose() {
    stopPositionStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final options = MapOptions(
      center: myPositon ?? const LatLng(0, 0),
      minZoom: 5,
      maxZoom: 18,
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
        point: myPositon ?? const LatLng(0, 0),
        builder: (context) => const Icon(
              Icons.person_pin,
              color: Colors.blueAccent,
              size: 40,
            ));

    MarkerLayer mLayer = MarkerLayer(
      markers: [userMarker],
    );

    FlutterMap map = FlutterMap(
      options: options,
      nonRotatedChildren: [tileLayer, mLayer],
    );

    const loadingWidget = Center(child: CircularProgressIndicator());

    return (myPositon == null) ? loadingWidget : map;
  }
}
