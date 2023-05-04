import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/users/users_cubit.dart';

import '../../../cubits/states/user_state.dart';
import '../../../entities/user.dart';

class DelUser extends StatelessWidget {
  DelUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete User Page'),
      ),
      body: BlocBuilder<UserDeleteCubit, UserState>(builder: (context, state) {
        if (state is UserInitialState) {
          return const CircularProgressIndicator();
        } else if (state is UsersLoadedState) {
          return Main(users: state.users);
        } else if (state is UserLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is UserDeleteFailureState) {
          // add error message later
          return const ErrorPage();
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

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Error'),
      content: Text('User not deleted! Try again'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({
    super.key,
    required this.users,
  });

  final List<User> users;

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  Widget build(BuildContext context) {
    return Center(
        child: ListView.separated(
      //padding: const EdgeInsets.all(12.0),
      itemCount: widget.users.length,
      itemBuilder: (_, int aIndex) {
        return ListTile(
          trailing: DeleteButton(id: widget.users[aIndex].id.toString()),
          title: Text(widget.users[aIndex].name),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    ));

    ////
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<UserDeleteCubit>(context).deleteUser(id);
      },
      child: const Text('Delete User'),
    );
  }
}

/*
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
        ],
      ),
    );
*/
