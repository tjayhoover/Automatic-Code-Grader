import 'dart:convert';

import 'package:project3_ui/entities/user.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:http/http.dart' as http;

import 'package:project3_ui/url.dart';

class OnlineUserRepository implements UserRepository {
  @override
  Future<List<User>> getAllUsers(int curId) async {
    var response = await http.get((Uri.parse('$serverURL/users')),
        headers: {"Authorization": curId.toString()});

    // test JsonString
    //String jsonString =
    //    '[{"id": 1,"name": "User1","role": "admin"},{"id": 2,"name": "User2","role": "student"},{"id": 4,"name": "User4","role": "instructor"}]';

    return (json.decode(response.body) as List)
        .map((i) => User.fromJson(i))
        .toList();
  }

  @override
  Future<bool> createUser(int curId, String username, String role) async {
    var response = await http.post((Uri.parse('$serverURL/users')),
        headers: {"Authorization": curId.toString()},
        body: "{'name': $username, 'role': $role}");

    if (response.statusCode == 404) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteUser(int curId, String id) async {
    var response = await http.delete((Uri.parse('$serverURL/users/$id')),
        headers: {"Authorization": curId.toString()});

    if (response.statusCode == 404) {
      return false;
    }
    return true;
  }
}
