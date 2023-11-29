import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:random_meetings/Common/app_communication_base.dart';
import 'package:random_meetings/Common/app_static_settings.dart';
import 'package:random_meetings/DTO/MarkersIn.dart';
import 'package:random_meetings/screens/room/room.dart';

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
        Connection.userX = myPositon!.longitude;
        Connection.userY = myPositon!.latitude;
      }
    });
  }

  Future<void> getMarkers() async {
    if (Connection.markersIns.isEmpty) {
      final preMarkers = await AppCommunicationBase.getMarkers();
      if (preMarkers != null) {
        Connection.markersIns = preMarkers;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    startPositionStream(_handlerPositionStream);
    super.initState();
    getMarkers();
  }

  @override
  void dispose() {
    stopPositionStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> drawMarkers() {
      List<Marker> markerPoints = List.empty(growable: true);
      for (var marker in Connection.markersIns) {
        markerPoints.add(Marker(
            width: 90,
            height: 90,
            point: LatLng(marker.x, marker.y),
            builder: (context) => MeetingMarker(markerData: marker)));
      }
      return markerPoints;
    }

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
        width: 48,
        height: 48,
        builder: (context) => ClipOval(
              child: Container(
                color: Colors.greenAccent,
                width: 100,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Image.network(Connection.getApiProfileImage(
                          Connection.localUser!.profilePic!)),
                    ),
                  ),
                ),
              ),
            ));

    MarkerLayer mLayer = MarkerLayer(
      markers: [userMarker, ...drawMarkers()],
    );

    FlutterMap map = FlutterMap(
      options: options,
      nonRotatedChildren: [tileLayer, mLayer],
    );

    const loadingWidget = Center(child: CircularProgressIndicator());

    return (myPositon == null) ? loadingWidget : map;
  }
}

class MeetingMarker extends StatelessWidget {
  const MeetingMarker({super.key, required this.markerData});

  final MarkerIn markerData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RoomScreen(markerData: markerData)));
      },
      child: Column(
        children: [
          ClipOval(
            child: Container(
              color: Colors.cyanAccent,
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: MarkerLogo(),
              ),
            ),
          ),
          Text("${markerData.interest.name} #${markerData.id}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)
        ],
      ),
    );
  }
}

class MarkerLogo extends StatelessWidget {
  const MarkerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Colors.blue,
        child: const Icon(Icons.pin_drop, color: Colors.white,),
      ),
    );
  }
}

class UserMarkerIcon extends StatelessWidget {
  const UserMarkerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
