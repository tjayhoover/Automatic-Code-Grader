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
}
