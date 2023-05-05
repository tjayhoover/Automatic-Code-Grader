import 'package:project3_ui/repositories/login/interface/login_repository.dart';
import 'package:project3_ui/entities/user.dart';

class LiveLoginRepository implements LoginRepository {
  @override
  User? user;

  @override
  Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(5, "String", "student");
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