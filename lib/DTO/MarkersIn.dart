import 'package:random_meetings/DTO/InterestData.dart';

class MarkerIn {
  final int id;
  final double x;
  final double y;
  final InterestData interest;

  const MarkerIn({required this.id, required this.x, required this.y, required this.interest});

  factory MarkerIn.fromJson(Map<String, dynamic> json) => MarkerIn(
    id: json["id"],
    x: json["x"],
    y: json["y"],
    interest: InterestData(
      id: json["interest"]["id"],
      name: json["interest"]["name"]
    )
  );

}