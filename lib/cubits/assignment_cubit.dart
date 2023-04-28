import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(AssignmentInitialState());
}
