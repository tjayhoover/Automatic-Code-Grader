import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/pages/instructor/upload_assignment/upload_assignment.dart';

import 'cubits/assignments/assignment_cubit.dart';
import 'pages/login/login.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<UploadAssignmentCubit>(
        create: (BuildContext context) => UploadAssignmentCubit(),
      )
    ],
    child: MaterialApp(
      title: 'Navigation Basics',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder())),
      home: LogInPage(),
    ),
  ));
}
