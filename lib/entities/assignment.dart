import 'dart:io';

class Assignment {
  late int id;
  late String name;
  late DateTime dueDate;
  late String desc;
  late List<String> inputs;
  late List<String> outputs;

  Assignment(this.name, this.dueDate, this.desc,
      {this.id = -1, this.inputs = const [], this.outputs = const []});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dueDate': dueDate.toIso8601String(),
        'description': desc,
        'inputFiles': inputs,
        'outputFiles': outputs
      };

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = DateTime.parse(json['dueDate']);
    desc = json['description'];
    inputs = json['inputFiles'] ?? [];
    outputs = json['outputFiles'] ?? [];
  }
}
