import 'package:project3_ui/entities/user.dart';

abstract class UserRepository {
  // Returns a list of all users
  Future<List<User>> getAllUsers();

  Future<bool> createUser(String username, String role);
  Future<bool> deleteUser(String username);

  Future<User> login(String username, String password);

  // TODO: Supply other functions needed for this interface
}
