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
  User logIn(String username, String password) {
    return User(69, username, "student");
  }
}
