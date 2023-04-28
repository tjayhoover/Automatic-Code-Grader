import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/pages/instructor/upload_assignment/upload_assignment.dart';

import 'cubits/assignment_cubit.dart';
import 'pages/login/login.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AssignmentCubit>(
        create: (BuildContext context) => AssignmentCubit(),
      )
    ],
    child: MaterialApp(
      title: 'Navigation Basics',
      home: UploadAssignment(),
    ),
  ));
}
