import 'package:shared_preferences/shared_preferences.dart';

import '../models/play.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userId", user.userId!);
    prefs.setString("name", user.name!);
    prefs.setString("email", user.email!);
    prefs.setString("phone", user.phone!);
    prefs.setString("type", user.type!);
    prefs.setString("token", user.token!);
    prefs.setString("renewToken", user.renewToken!);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? name = prefs.getString("name");
    String? email = prefs.getString("name");
    String? phone = prefs.getString("phone");
    String? type = prefs.getString("type");
    String? token = prefs.getString("token");
    String? renewToken = prefs.getString("renewToken");

    return User(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      type: type,
      token: token,
      renewToken: renewToken,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    return token!;
  }
}
