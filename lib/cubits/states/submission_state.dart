import 'package:equatable/equatable.dart';


abstract class SubmissionState extends Equatable {}

class SubmissionInitialState extends SubmissionState {
  @override
  List<Object?> get props => [];
}

class SubmissionLoadingState extends SubmissionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubmissionLoadedState extends SubmissionState {
  final int casesPassed;
  final int totalCases;
  SubmissionLoadedState(this.casesPassed, this.totalCases);
  @override
  List<Object?> get props => [casesPassed, totalCases];
}

class SubmissionFailureState extends SubmissionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
