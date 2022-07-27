import 'package:universal_platform/universal_platform.dart';

class CustomIP{
  CustomIP._();

   static get apiPort => 5000;
   static get socketPort => 3000;
 
  static get publicIp => "103.163.183.20";
  static get localIp=> "192.168.1.74";

  static String get baseUrl {
    
    if(UniversalPlatform.isWeb)
  {
    // var url=Uri.base.toString().split(":")[1].replaceAll("//","http://");
    final url=Uri.base.toString();
    final finalUrl="http://${url.split('/')[2].split(':')[0]}";
   
    return finalUrl;
  }
  else{

    return const String.fromEnvironment("HOST");
  }
  } 

  static String get apiBaseUrl=> "$baseUrl:$apiPort/v1/";
  static String get socketBaseUrl=> "$baseUrl:$socketPort/";
}