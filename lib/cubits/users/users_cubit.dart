import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/user.dart';
import 'package:project3_ui/cubits/states/user_state.dart';
import 'package:project3_ui/repositories/users/implementation/mock_user_repository.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/login/interface/login_repository.dart';

class UserListCubit extends Cubit<UserState> {
  late UserRepository repo;

  UserListCubit() : super(UserInitialState()) {
    repo = GetIt.I<UserRepository>();
  }

  void loadUsers() async {
    try {
      emit(UserLoadingState());
      User? user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        final users = await _fetchUsers(user.id);
        if (users.isEmpty) {
          emit(UsersFailureState());
        } else {
          emit(UsersLoadedState(users));
        }
      } else {
        emit(UsersFailureState());
      }
    } catch (e) {
      emit(UsersFailureState());
    }
  }

  Future<List<User>> _fetchUsers(int curId) async {
    return repo.getAllUsers(curId);
  }
}

class UserCreateCubit extends Cubit<UserState> {
  late UserRepository repo;

  UserCreateCubit() : super(UserInitialState()) {
    repo = GetIt.I<UserRepository>();
  }

  void createUser(String username, String role) async {
    try {
      emit(UserLoadingState());
      User? user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        final users = await _createUser(user.id, username, role);
        if (!users) emit(UserCreateFailureState());
        emit(UserCreatedState());
      } else {
        emit(UserCreateFailureState());
      }
    } catch (e) {
      emit(UserCreateFailureState());
    }
  }

  void resetState() {
    emit(UserInitialState());
  }

  Future<bool> _createUser(int curId, String username, String role) async {
    return repo.createUser(curId, username, role);
  }
}

class UserDeleteCubit extends Cubit<UserState> {
  late UserRepository repo;

  UserDeleteCubit() : super(UserInitialState()) {
    repo = GetIt.I<UserRepository>();
  }

  void deleteUser(String username) async {
    try {
      emit(UserLoadingState());
      User? user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        final success = await _deleteUser(user.id, username);
        if (!success) emit(UserDeleteFailureState());
        emit(UserDeletedState());
      } else {
        emit(UserDeleteFailureState());
      }
    } catch (e) {
      emit(UserDeleteFailureState());
    }
  }

  void getAllUsers() async {
    try {
      emit(UserLoadingState());
      User? user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        final list = await _getAllUsers(user.id);
        if (list.isEmpty) emit(UsersFailureState());
        emit(UsersLoadedState(list));
      } else {
        emit(UsersFailureState());
      }
    } catch (e) {
      emit(UsersFailureState());
    }
  }

  void resetState() {
    emit(UserInitialState());
  }

  Future<bool> _deleteUser(int curId, String username) async {
    return repo.deleteUser(curId, username);
  }

  Future<List<User>> _getAllUsers(int curId) async {
    return repo.getAllUsers(curId);
  }
}
