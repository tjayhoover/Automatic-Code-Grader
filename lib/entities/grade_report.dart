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

  Map<String, dynamic> toJson() => {
        'userid': id,
        'username': name,
        'dateSubmitted': submissionDate,
        'casesPassed': casesPassed,
        'totalCases': totalCases
      };

  GradeReport.fromJson(Map<String, dynamic> json) {
    id = json['userid'];
    name = json['username'];
    submissionDate = DateTime.parse(json['dateSubmitted']);
    casesPassed = json['casesPassed'];
    totalCases = json['totalCases'];
  }
}
