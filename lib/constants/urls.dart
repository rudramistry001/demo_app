import 'package:demo_app/constants/base_url.dart';

class UrlConstant {
  static const String uatUrl = "http://localhost:8080";

  // static const String uatUrl = "api-uat.softsages.com";
  static const String prodUrl = "";
  static String baseUrl = BaseUrl().isProd ? prodUrl : uatUrl;

  static String register = "/register";

  static String login = "/login";
}
