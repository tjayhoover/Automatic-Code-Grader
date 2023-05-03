import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/user_state.dart';
import 'package:project3_ui/cubits/users/users_cubit.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});

  final TextEditingController username = TextEditingController();
  final TextEditingController role = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User Page'),
      ),
      body: BlocBuilder<UserCreateCubit, UserState>(builder: (context, state) {
        if (state is UserInitialState) {
          return Main(username: username, role: role);
        } else if (state is UserLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is UserCreateFailureState) {
          // add error handling later
          return const ErrorPage();
        } else if (state is UserCreatedState) {
          return Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Success')));
        } else {
          return Container();
        }
      }),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Error'),
      content: Text('User not created! Try again'),
    );
  }
}

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.username,
    required this.role,
  });

  final TextEditingController username;
  final TextEditingController role;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            style: TextStyle(fontSize: 30),
            'To create a user enter their desired username and role. Users can only be created one at a time.',
          ),
          TextField(
            controller: username,
            decoration: InputDecoration(
              //focusColor:const  Color.fromARGB(255, 0, 255, 8),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => username.clear(),
              ),
              border: const OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),
          TextField(
            controller: role,
            decoration: InputDecoration(
              //focusColor:const  Color.fromARGB(255, 0, 255, 8),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => role.clear(),
              ),
              border: const OutlineInputBorder(),
              hintText: 'User Role',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserCreateCubit>(context)
                      .createUser(username.text, role.text);
                },
                child: const Text('Add User'),
              ),
              ElevatedButton(
                onPressed: () {
                  username.clear();
                  role.clear();
                },
                child: const Text('Clear Fields'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
