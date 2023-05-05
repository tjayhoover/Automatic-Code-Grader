import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/user_state.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'package:project3_ui/entities/user.dart';
import 'package:get_it/get_it.dart';

class LoginCubit extends Cubit<UserState> {
  late UserRepository userRepo;
  LoginCubit() : super(UserInitialState()) {
    userRepo = GetIt.I<UserRepository>();
  }


  void logIn(String username, String password) async {
    try {
      emit(UserLoadingState());
      final user = await userRepo.login(username, password);
      emit(UserLoadedState(user));
    } catch (e) {
      emit(UserFailureState());
    }
  }
}
