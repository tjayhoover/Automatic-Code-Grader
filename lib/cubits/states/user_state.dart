import 'package:equatable/equatable.dart';

import 'package:project3_ui/entities/user.dart';

abstract class UserState extends Equatable {}

class UserInitialState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final User user;
  UserLoadedState(this.user);
  @override
  List<Object?> get props => [user];
}

class UserFailureState extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UsersLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UsersLoadedState extends UserState {
  final List<User> users;
  UsersLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UsersFailureState extends UserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
