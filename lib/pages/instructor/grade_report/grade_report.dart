import 'package:flutter/material.dart';

class InstructorGradeReport extends StatelessWidget {
  const InstructorGradeReport({super.key});
  static const String _title = 'Assignment Grade Reports';
  static const List<String> _studentNames = <String>[
    'Alice',
    'Bobby',
    'Charlie',
    'Doug',
    'Eve',
  ];
  static const List<String> _assignmentNames = <String>[
    'Hello World!',
    'Add Two Numbers',
    'Beekeeper',
    'Volim',
    'Steal Tyler\'s Internship',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const GradeReportStatefulWidget(
        studentNames: _studentNames,
        assignmentNames: _assignmentNames,
      ),
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
          subtitle: const Text('avg: x\tmin: y\tmax:  z'),
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
