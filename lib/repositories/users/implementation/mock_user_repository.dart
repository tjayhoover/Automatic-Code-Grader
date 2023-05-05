import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:project3_ui/entities/user.dart';

class MockUserRepository implements UserRepository {
  @override
  List<User> getAllUsers() {
    List<User> userList = [
      User(1, "Tyler", "student"),
      User(2, "Brandon", "student"),
      User(3, "Adam", "student"),
    ];
    return userList;
  }

  @override
  bool createUser(String username, String role) {
    return true;
  }

  @override
  bool deleteUser(String user) {
    return true;
  }

  @override
  Future<User> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(5, "String", "student");
  }
}
