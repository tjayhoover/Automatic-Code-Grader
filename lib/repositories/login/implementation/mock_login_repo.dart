import 'package:project3_ui/repositories/login/interface/login_repository.dart';
import 'package:project3_ui/entities/user.dart';

class MockLoginRepository implements LoginRepository {
  @override
  User? user;

  @override
  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username.length == 6) {
      return User(5, username, "student");
    } else {
      return null;
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
