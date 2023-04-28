import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/assignment_list/assignment_list_bloc.dart';

import 'pages/login/login.dart';

void main() {
  runApp(BlocProvider(
    create: (BuildContext context) => AssignmentListBloc(),
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
