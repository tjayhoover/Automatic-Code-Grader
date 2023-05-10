import 'package:project3_ui/repositories/login/interface/login_repository.dart';
import 'package:project3_ui/entities/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project3_ui/url.dart';

class LiveLoginRepository implements LoginRepository {
  @override
  User? user;

  @override
  Future<User?> login(String username, String password) async {
    try {
      var response = await http.post((Uri.parse('$serverURL/login')),
          body: jsonEncode({"username": username, "password": password}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      // In this case the login was successful
      print(response.statusCode);
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      }
      // In this case the login was unsuccessful
      else {
        return null;
      }
    } catch (e) {
      // Debug output
      print(e);
      return null;
    }
  }

  @override
  void setCurrentUser(User u) {
    user = u;
  }

  @override
  User? getCurrentUser() {
    return user;
  }
}
