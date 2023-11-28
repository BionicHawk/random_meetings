import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:random_meetings/DTO/Comment.dart';
import 'package:random_meetings/DTO/UserIn.dart';
import 'package:random_meetings/DTO/UserOut.dart';
import '../DTO/InterestData.dart';
import '../DTO/MarkersIn.dart';
import 'app_static_settings.dart';

class AppCommunicationBase {
  static bool _internetIssue = false;

  static Future<List<InterestData>?> getAllInterests() async {
    try {
      final rawData = await Dio().get(Connection.getApiUrlAllInterests());
      _internetIssue = false;
      return _translateInterests(rawData);
    } catch (e) {
      _internetIssue = true;
    }
    return null;
  }

  static Future<List<Comment>?> getComments(int roomId) async {
    try {
      List<Comment> comments = List.empty(growable: true);
      final rawData = await Dio().get(Connection.getApiCommentsUrl(roomId));
      if (rawData.statusCode != 404) {
        for (var comment in rawData.data) {
          comments.add(Comment.fromJson(comment));
        }
      }
      _internetIssue = false;
      return comments;
    } catch (e) {
      _internetIssue = true;
    }
    return null;
  }

  static Future<ValidationType> trySendNewUser(UserForm user) async {
    // make some validations
    if (user.password != user.confirmedPass)
      return ValidationType.notMatchingPass;
    if (!EmailValidator.validate(user.email))
      return ValidationType.notValidEmail;

    final response = await _sendNewUser(UserOut.fromForm(user));

    if (isAnInternetIssue()) return ValidationType.serverOrInternetError;

    return ValidationType.succesful;
  }

  static Future<ValidationType> tryLogin(
      String username, String password) async {
    final credentials = {"username": username, "password": password};

    try {
      final response = await Dio().post(Connection.getApiUrlLogin(), data: credentials);

      if (response.statusCode == 400) {
        if (response.data["err"] == "invalidCredentials") {
          return ValidationType.invalidCredentials;
        }
      }
      Connection.localUser = UserIn.fromJson(response.data["user"]);
      _internetIssue = false;

    } catch (e) {
      _internetIssue = true;
      return ValidationType.serverOrInternetError;
    }

    return ValidationType.succesful;
  }

  static Future<List<MarkerIn>?> getMarkers() async {
    try {
      final response = await Dio().get(Connection.getApiMapPoints());
      if (response.statusCode == 201) {
        List<MarkerIn> markers = List.empty(growable: true);
        final rawMarkers = response!.data["markers"];
        for (var mark in rawMarkers) {
          markers.add(MarkerIn.fromJson(mark));
        }
        _internetIssue = false;
        return markers;
      }
    } catch (e) {
      _internetIssue = true;
    }

    return null;
  }

  static List<InterestData> _translateInterests(Response<dynamic> res) {
    final rawInterests = res.data["data"];
    List<InterestData> interests = List.empty(growable: true);

    for (var raw in rawInterests) {
      interests.add(InterestData.fromJson(raw));
    }

    return interests;
  }

  static Future<Response<dynamic>?> _sendNewUser(UserOut user) async {
    try {
      final response = await Dio()
          .post(Connection.getApiUrlCreateUser(), data: user.toJson());
      _internetIssue = false;
      return response;
    } catch (e) {
      _internetIssue = true;
    }
    return null;
  }

  static bool isAnInternetIssue() {
    return _internetIssue;
  }
}

enum ValidationType {
  notMatchingPass,
  notValidEmail,
  notValidUsername,
  serverOrInternetError,
  invalidCredentials,
  succesful
}
