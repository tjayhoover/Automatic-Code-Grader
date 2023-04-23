class Assignment {
  late int id;
  late String name;
  late DateTime dueDate;
  late String desc;

  Assignment(this.id, this.name, this.dueDate, this.desc);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'dueDate': dueDate, 'desc': desc};

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = json['dueDate'];
    desc = json['desc'];
  }
}
