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
    print("here");
    try {
      var response = await http.post((Uri.parse('$serverURL/login')),
          body: jsonEncode({"username": username, "password": password}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      print(response.statusCode.toString());
      // In this case the log in was successful
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        // In this case the log in was unsuccessful
        return null;
      }
    } catch (e) {
      print(e);
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
