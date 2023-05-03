import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/grade_reports/student_grade_report_cubit.dart';
import 'package:project3_ui/cubits/users/users_cubit.dart';
import 'package:project3_ui/repositories/assignments/implementation/mock_assignment_repository.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'package:project3_ui/repositories/student_grade_reports/implementation/mock_sgr_repository.dart';
import 'package:project3_ui/repositories/student_grade_reports/interface/student_grade_reports_repository.dart';
import 'package:project3_ui/repositories/users/implementation/mock_user_repository.dart';
import 'package:project3_ui/repositories/users/interface/user_repository.dart';
import 'pages/login/login.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  GetIt.I.registerSingleton<UserRepository>(MockUserRepository());
  GetIt.I.registerSingleton<StudentGradeReportRepository>(MockSgrRepository());
  GetIt.I.registerSingleton<AssignmentRepository>(MockAssignmentRepository());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => AssignmentListCubit()),
      BlocProvider(create: (BuildContext context) => UserListCubit()),
      BlocProvider(create: (BuildContext context) => UploadAssignmentCubit()),
      BlocProvider(create: (BuildContext context) => UserDeleteCubit()),
      BlocProvider(create: (BuildContext context) => UserCreateCubit()),
      BlocProvider(create: (BuildContext context) => StudentGradeReport()),
    ],
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
