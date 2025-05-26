import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketHelpConstants {
  static SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
  };

  static const String server = 'http://minecraftslaves.duckdns.org:8082';

  static Map<String, String> headerWithAuth() {
    String? token = sharedPreferences.getString('token');
    if (token != "") {
      headers.addEntries(<String, String>{'bearerAuth': token ?? ""}.entries);
    }
    return headers;
  }

  static void addAuthHeader(String token) {
    headers.addEntries(<String, String>{'bearerAuth': token}.entries);
  }
}
