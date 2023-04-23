import 'package:flutter_bloc/flutter_bloc.dart';

import 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(AssignmentInitialState());
}
