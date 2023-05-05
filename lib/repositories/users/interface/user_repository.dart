import 'package:project3_ui/entities/user.dart';

abstract class UserRepository {
  // Returns a list of all users
  Future<List<User>> getAllUsers(int curId);

  Future<bool> createUser(int curId, String username, String role);
  Future<bool> deleteUser(int curId, String username);

}
