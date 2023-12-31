import 'package:random_meetings/DTO/MarkersIn.dart';

import '../DTO/UserIn.dart';

class Connection {
  static const String _hostname =
      "https://express-ts-prisma.3.us-1.fl0.io/"; // Ingresar el hostname donde se aloja el servidor
  static const int _port = 80; // Ingresar el puerto donde escucha el servidor
  static UserIn? localUser;
  static List<MarkerIn> markersIns = List.empty(growable: true);
  static double userX = 0.0;
  static double userY = 0.0;

  // Con esta funcion se traen la api desde el punto raiz
  static String getApiUrl() {
    return _hostname;
  }

  // Con esta función se traen la url de los intereses
  static String getApiUrlAllInterests() {
    return "${getApiUrl()}interest/all";
  }

  // Con esta función se traen la url de la creación de perfiles
  static String getApiUrlCreateUser() {
    return "${getApiUrl()}user/new";
  }
  // Con esta función se traen la url de iniciar sesión
  static String getApiUrlLogin() {
    return "${getApiUrl()}login";
  }

  static String getApiProfileImage(String imageLocalUri) {
    if (imageLocalUri != "/images/profile_pics/default_profile_img.jpg") {
      return imageLocalUri;
    }
    if (imageLocalUri[0] == "/") {
      String newStr = "";
      for (int i = 1; i < imageLocalUri.length; i++) {
        newStr += imageLocalUri[i];
      }
      return "${getApiUrl()}$newStr";
    }
    return "${getApiUrl()}$imageLocalUri";
  }

  static String getApiMapPoints() {
    return "${getApiUrl()}maps/points";
  }

  static String getApiCommentsUrl(int roomId) {
    return "${getApiUrl()}maps/comment/$roomId";
  }

  static String getUpdateUserUrl(int userId) {
    return "${getApiUrl()}user/update/$userId";
  }

  static String getApiUserByIdUrl(int userId) {
    return "${getApiUrl()}user/$userId";
  }

}
