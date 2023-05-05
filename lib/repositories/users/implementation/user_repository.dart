import 'dart:convert';

import 'package:project3_ui/entities/user.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:http/http.dart' as http;

class OnlineUserRepository implements UserRepository {
  @override
  Future<List<User>> getAllUsers() async {
    var response = await http.get((Uri.parse('../users')), headers: {});

    // test JsonString
    //String jsonString =
    //    '[{"id": 1,"name": "User1","role": "admin"},{"id": 2,"name": "User2","role": "student"},{"id": 4,"name": "User4","role": "instructor"}]';

    return (json.decode(response.body) as List)
        .map((i) => User.fromJson(i))
        .toList();
  }

  @override
  Future<bool> createUser(String username, String role) async {
    var response = await http.post((Uri.parse('../users')),
        headers: {'name': username, 'role': role});

    if (response.statusCode == 404) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteUser(String id) async {
    var response = await http.delete((Uri.parse('../users/$id')),
        headers: {});

    if (response.statusCode == 404) {
      return false;
    }
    return true;
  }

  // to be implemented
  @override
  Future<User> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(5, "String", "student");
  }
}
