import 'package:project3_ui/entities/user.dart';

abstract class UserRepository {
  // Returns a list of all users
  List<User> getAllUsers();

  bool createUser(String username, String role);
  bool deleteUser(String username);

  Future<User> login(String username, String password);

  // TODO: Supply other functions needed for this interface
}
