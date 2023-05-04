import 'package:project3_ui/entities/user.dart';

abstract class UserRepository {
  // Returns a list of all users
  List<User> getAllUsers();

  User logIn(String username, String password);

  // TODO: Supply other functions needed for this interface
}
