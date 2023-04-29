import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project3_ui/entities/user.dart';
import 'package:project3_ui/cubits/states/user_state.dart';
import 'package:project3_ui/repositories/users/implementation/mock_user_repository.dart';

class UserListCubit extends Cubit<UserState> {
  UserListCubit() : super(UserInitialState());

  void loadUsers() async {
    try {
      final assignments = await _fetchUsers();
      emit(UsersLoadedState(assignments));
    } catch (e) {
      emit(UsersFailureState());
    }
  }

  // This is bad and just for testing.
  // Need to depend on an abstraction, not this concrete implementation.
  final userRepo = MockUserRepository();

  // Query the assignment repo for the pending assignments
  Future<List<User>> _fetchUsers() async {
    // TODO: Implement fetching of assignments from API or database
    return userRepo.getAllUsers();
  }
}