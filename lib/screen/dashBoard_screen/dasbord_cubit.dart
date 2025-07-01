import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void updateMessage(String newMessage) {
    emit(DashboardState(message: newMessage));
  }
}

