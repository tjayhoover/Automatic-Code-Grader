import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/grade_reports/student_grade_report_cubit.dart';
import 'package:project3_ui/entities/grade_report.dart';
import '../../../cubits/states/student_grade_report_state.dart';

class StudentGradeReportPage extends StatelessWidget {
  const StudentGradeReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grade Report")),
      body: BlocBuilder<StudentGradeReport, StudentGradeReportState>(
        builder: (context, state) {
          if (state is StudentGradeReportInitialState) {
            return Container();
          } else if (state is StudentGradeReportLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentGradeReportLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: state.reports.length,
              itemBuilder: (context, index) =>
                  gradeReportItem(state.reports[index]),
            );
          } else if (state is StudentGradeReportFailureState) {
            return const Center(
              child: Text("ERROR"),
            );
          }
          return Container();
        },
      ),
    );
  }

  gradeReportItem(GradeReport report) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            '${report.name} ${report.casesPassed} out of ${report.totalCases}'),
      ),
    );
  }
}
