import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/grade_reports/instructor_grade_report_cubit.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';
import 'package:project3_ui/entities/assignment_grade_report.dart';

class InstructorGradeReportWidget extends StatelessWidget {
  const InstructorGradeReportWidget({super.key});
  static const String _title = 'Assignment Grade Reports';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: BlocBuilder<InstructorGradeReport, InstructorGradeReportState>(
          builder: (context, state) {
        if (state is InstructorGradeReportLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is InstructorGradeReportLoadedState) {
          return GradeReportStatefulWidget(
            gradeReport: state.gradeReport,
          );
        } else if (state is InstructorGradeReportFailureState) {
          return const Center(
            child: Text("Error. Please contact your system administrator."),
          );
        }
        // Default return
        return Container();
      }),
    );
  }
}

class GradeReportStatefulWidget extends StatefulWidget {
  const GradeReportStatefulWidget({
    super.key,
    required this.gradeReport,
  });

  final Map<String, List<AssignmentGradeReport>> gradeReport;

  @override
  State<GradeReportStatefulWidget> createState() => _GradeReportState();
}

class _GradeReportState extends State<GradeReportStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Drawer(
            child: ListView.separated(
      padding: const EdgeInsets.all(12.0),
      itemCount: widget.gradeReport.keys.length,
      itemBuilder: (_, int aIndex) {
        List<String> aNames = widget.gradeReport.keys.toList();
        return ExpansionTile(
          title: Text(aNames[aIndex]),
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.gradeReport[aNames[aIndex]]!.length,
              itemBuilder: (_, int sIndex) {
                String name =
                    widget.gradeReport[aNames[aIndex]]![sIndex].studentName;
                String grade = widget
                    .gradeReport[aNames[aIndex]]![sIndex].casesPassed
                    .toString();
                String total = widget
                    .gradeReport[aNames[aIndex]]![sIndex].totalCases
                    .toString();
                return ListTile(
                  title: Text(name),
                  subtitle: Text('$grade / $total'),
                );
              },
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    )));
  }
}
