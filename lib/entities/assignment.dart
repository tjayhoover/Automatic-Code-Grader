import 'dart:io';

class Assignment {
  late int id;
  late String name;
  late DateTime dueDate;
  late String desc;
  late List<File> inputs;
  late List<File> outputs;

  Assignment(this.name, this.dueDate, this.desc,
      {this.id = -1, this.inputs = const [], this.outputs = const []});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dueDate': dueDate,
        'desc': desc,
        'inputFiles': inputs,
        'outputFiles': outputs
      };

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = json['dueDate'];
    desc = json['desc'];
    inputs = json['inputFiles'] ?? [];
    outputs = json['outputFiles'] ?? [];
  }
}
