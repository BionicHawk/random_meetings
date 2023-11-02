class Connection {
  static const String _hostname =
      "192.168.1.142"; // Ingresar el hostname donde se aloja el servidor
  static const int _port = 3000; // Ingresar el puerto donde escucha el servidor

  // Con esta funcion se traen la api desde el punto raiz
  static String getApiUrl() {
    return "http://$_hostname:$_port/";
  }

  // Con esta función se traen la url de los intereses
  static String getApiUrlAllInterests() {
    return "${getApiUrl()}interest/all";
  }

  // Con esta función se traen la url de la creación de perfiles
  static String getApiUrlCreateUser() {
    return "${getApiUrl()}user/new";
  }

}
