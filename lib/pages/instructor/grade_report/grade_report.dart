import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/grade_reports/instructor_grade_report_cubit.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';

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
            studentNames:
                state.gradeReportList.map((e) => e.studentName).toList(),
            assignmentNames: state.assignmentNames,
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
    required this.studentNames,
    required this.assignmentNames,
  });

  final List<String> studentNames;
  final List<String> assignmentNames;

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
      itemCount: widget.assignmentNames.length,
      itemBuilder: (_, int aIndex) {
        return ExpansionTile(
          title: Text(widget.assignmentNames[aIndex]),
          subtitle: const Text('stats go here'),
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.studentNames.length,
              itemBuilder: (_, int sIndex) {
                return ListTile(title: Text(widget.studentNames[sIndex]));
              },
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    )));
  }
}
