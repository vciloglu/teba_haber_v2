import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManger {
  // save local storage
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    return true;
  }

  // read token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  // has  token
  Future<bool> hasToken() async {
    String? token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
