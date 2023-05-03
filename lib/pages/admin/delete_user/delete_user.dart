import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/users/users_cubit.dart';

import '../../../cubits/states/user_state.dart';

class DelUser extends StatelessWidget {
  DelUser({super.key});

  final TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User Page'),
      ),
      body: BlocBuilder<UserDeleteCubit, UserState>(builder: (context, state) {
        if (state is UserInitialState) {
          return Main(username: username);
        } else if (state is UserLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is UserDeleteFailureState) {
          // add error message later
          return Main(username: username);
        } else if (state is UserDeletedState) {
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

class Main extends StatelessWidget {
  const Main({
    super.key,
    required this.username,
  });

  final TextEditingController username;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            style: TextStyle(fontSize: 30),
            'Enter the username of the user you want to delete. Users can only be deleted one at a time.   ',
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
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<UserDeleteCubit>(context)
                  .deleteUser(username.text);
            },
            child: const Text('Delete User'),
          ),
        ],
      ),
    );
  }
}
