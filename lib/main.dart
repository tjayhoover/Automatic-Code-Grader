import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/assignments/assignments_cubit.dart';

import 'pages/login/login.dart';

void main() {
  runApp(BlocProvider(
    create: (BuildContext context) => AssignmentListCubit(),
    child: MaterialApp(
      title: 'Code Grading Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogInPage(),
    ),
  ));
}
