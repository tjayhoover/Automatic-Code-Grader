import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/users/users_cubit.dart';
import 'add_user/add_user.dart';
import 'delete_user/delete_user.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Add User'),
              onPressed: () {
                var Cubit = BlocProvider.of<UserCreateCubit>(context);
                Cubit.resetState();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUser()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Delete User'),
              onPressed: () {
                var Cubit = BlocProvider.of<UserDeleteCubit>(context);
                Cubit.resetState();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DelUser()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
