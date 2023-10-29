import 'dart:convert';

InterestData interestDataFromJson(String str) =>
    InterestData.fromJson(json.decode(str));

String interestDataToJson(InterestData data) => json.encode(data.toJson());

class InterestData {
  final int id;
  final String name;

  InterestData({
    required this.id,
    required this.name,
  });

  factory InterestData.fromJson(Map<String, dynamic> json) => InterestData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
