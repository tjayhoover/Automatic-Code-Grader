import 'package:equatable/equatable.dart';

import '../entities/assignment.dart';

abstract class AssignmentState extends Equatable {}

class AssignmentInitialState extends AssignmentState {
  @override
  List<Object?> get props => [];
}

class AssignmentLoadingState extends AssignmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AssignmentLoadedState extends AssignmentState {
  final Assignment assignment;
  AssignmentLoadedState(this.assignment);
  @override
  List<Object?> get props => [assignment];
}

class AssignmentFailureState extends AssignmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AssignmentsLoadingState extends AssignmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AssignmentsLoadedState extends AssignmentState {
  final List<Assignment> assignments;
  AssignmentsLoadedState(this.assignments);
  @override
  List<Object?> get props => [assignments];
}

class AssignmentsFailureState extends AssignmentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
