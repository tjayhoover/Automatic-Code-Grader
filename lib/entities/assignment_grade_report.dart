class AssignmentGradeReport {
  // This object represents a single grade report from a student for the
  // implied assignment. It contains the fields returned by the instructor
  // grade report endpoint of the backend.
  late int studentID;
  late String studentName;
  late DateTime submissionDate;
  late int casesPassed;
  late int totalCases;

  AssignmentGradeReport(this.studentID, this.studentName, this.submissionDate,
      this.casesPassed, this.totalCases);

  Map<String, dynamic> toJson() {
    return {
      'userid': studentID,
      'username': studentName,
      'dateSubmitted': submissionDate.toIso8601String(),
      'casesPassed': casesPassed,
      'totalCases': totalCases,
    };
  }

  AssignmentGradeReport.fromJson(Map<String, dynamic> json) {
    studentID = json['userid'];
    studentName = json['username'];
    submissionDate = DateTime.parse(json['dateSubmitted']);
    casesPassed = json['casesPassed'];
    totalCases = json['totalCases'];
  }
}
