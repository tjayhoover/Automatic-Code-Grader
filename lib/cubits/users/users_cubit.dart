import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/user.dart';
import 'package:project3_ui/cubits/states/user_state.dart';
import 'package:project3_ui/repositories/users/implementation/mock_user_repository.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:get_it/get_it.dart';

class UserListCubit extends Cubit<UserState> {
  late UserRepository repo;
  
  UserListCubit() : super(UserInitialState()) {
    repo = GetIt.I<UserRepository>();
  }

  void loadUsers() async {
    try {
      final users = await _fetchUsers();
      emit(UsersLoadedState(users));
    } catch (e) {
      emit(UsersFailureState());
    }
  }


  Future<List<User>> _fetchUsers() async {
    return repo.getAllUsers();
  }
}

class UserCreateCubit extends Cubit<UserState> {
  late UserRepository repo;

  UserCreateCubit() : super(UserInitialState()){
     repo = GetIt.I<UserRepository>();
  }

  void createUser(String username, String role) async {
    try {
      emit(UserLoadingState());
      final users = await _createUser(username, role);
      if (!users) throw Null;
      emit(UserCreatedState());
    } catch (e) {
      emit(UserCreateFailureState());
    }
  }

  void resetState() {
    emit(UserInitialState());
  }

  Future<bool> _createUser(String username, String role) async {
    return repo.createUser(username, role);
  }
}

class UserDeleteCubit extends Cubit<UserState> {
  late UserRepository repo;

  UserDeleteCubit() : super(UserInitialState()){
     repo = GetIt.I<UserRepository>();
  }

  void deleteUser(String username) async {
    try {
      emit(UserLoadingState());
      final success = await _deleteUser(username);
      if (!success) throw Null;
      emit(UserDeletedState());
    } catch (e) {
      emit(UserDeleteFailureState());
    }
  }

  void getAllUsers() async {
    try {
      emit(UserLoadingState());
      final list = await _getAllUsers();
      if (list.isEmpty) throw Null;
      emit(UsersLoadedState(list));
    } catch (e) {
      emit(UsersFailureState());
    }
  }

  void resetState() {
    emit(UserInitialState());
  }

  Future<bool> _deleteUser(String username) async {
    return repo.deleteUser(username);
  }

  Future<List<User>> _getAllUsers() async {
    return repo.getAllUsers();
  }
}
