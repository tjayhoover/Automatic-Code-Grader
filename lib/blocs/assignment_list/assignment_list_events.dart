part of 'assignment_list_bloc.dart';

abstract class AssignmentEvent {
  const AssignmentEvent();
}

class LoadAssignments extends AssignmentEvent {}

class AddAssignment extends AssignmentEvent {
  final Assignment assignment;

  const AddAssignment(this.assignment);
 

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddAssignment && o.assignment == assignment;
  }

  @override
  int get hashCode => assignment.hashCode;
}

class DeleteAssignment extends AssignmentEvent {
  final Assignment assignment;

  const DeleteAssignment(this.assignment);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DeleteAssignment && o.assignment == assignment;
  }

  @override
  int get hashCode => assignment.hashCode;
}
