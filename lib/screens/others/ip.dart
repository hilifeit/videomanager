import 'package:universal_platform/universal_platform.dart';

class CustomIP {
  CustomIP._();
  static get production {
    if (Uri.base.port == 443) {
      return true;
    } else {
      return false;
    }
  }

  static get apiPort => 5000;
  static get socketPort => 3000;

  static get publicIp => "103.163.183.20";
  static get localIp => "192.168.1.74";

  static String get baseUrl {
    if (UniversalPlatform.isWeb) {
      // var url=Uri.base.toString().split(":")[1].replaceAll("//","http://");
      final url = Uri.base.toString();
      final finalUrl =
          "${production ? "https" : "http"}://${url.split('/')[2].split(':')[0]}";

      return finalUrl;
    } else {
      return const String.fromEnvironment("HOST");
    }
  }

  static String get apiBaseUrl {
    if (UniversalPlatform.isWeb) {
      var url = production ? "$baseUrl/api/" : "$baseUrl:$apiPort/v1/";

      return url;
    } else {
      return "${const String.fromEnvironment("HOST")}:$apiPort/v1/";
    }
  }

  // static String get apiBaseUrl=> "$baseUrl:$apiPort/v1/";
  static String get socketBaseUrl {
    if (UniversalPlatform.isWeb) {
      String url = production
          ? baseUrl.replaceAll("//", "//socket.")
          : "$baseUrl:$socketPort/";

      return url;
    } else {
      return "${const String.fromEnvironment("HOST")}:$socketPort";
    }

    // String url = "${baseUrl.replaceAll("https", "http")}/socket/";
  }

  // static String get socketBaseUrl=> "$baseUrl:$socketPort/";
}
