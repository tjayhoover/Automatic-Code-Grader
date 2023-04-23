class GradeReport {
  late int id;
  late String name;
  late DateTime dueDate;
  late DateTime submissionDate;
  late String desc;
  late int casesPassed;
  late int totalCases;

  GradeReport(this.id, this.name, this.dueDate, this.submissionDate, this.desc,
      this.casesPassed, this.totalCases);
}
