import 'package:dio/dio.dart';
import '../DTO/InterestData.dart';
import 'app_static_settings.dart';

class AppCommunicationBase {

  static bool _internetIssue = false;

  static Future<List<InterestData>?> getAllInterests() async {
    try {
      final rawData = await Dio().get(Connection.getApiUrlAllInterests());
      _internetIssue = false;
      return _translateInfo(rawData);
    } catch (e) {
      _internetIssue = true;
    }
    return null;
  }

  static List<InterestData> _translateInfo(Response<dynamic> res) {
    final rawInterests = res.data["data"];
    List<InterestData> interests = List.empty(growable: true);

    for (var raw in rawInterests) {
      interests.add(InterestData.fromJson(raw));
    }

    return interests;
  }

  static bool isAnInternetIssue() {
    return _internetIssue;
  }

}