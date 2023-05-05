import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:project3_ui/entities/user.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<List<User>> getAllUsers(int curId) async{
    List<User> userList = [
      User(1, "Tyler", "student"),
      User(2, "Brandon", "student"),
      User(3, "Adam", "student"),
    ];
    return userList;
  }

  @override
  Future<bool> createUser(int curId, String username, String role) async {
    return true;
  }

  @override
  Future<bool> deleteUser(int curId, String user) async {
    return true;
  }
}
