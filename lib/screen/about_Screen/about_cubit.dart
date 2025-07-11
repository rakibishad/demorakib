import 'package:flutter_bloc/flutter_bloc.dart';

import '../dashBoard_screen/dashboard_state.dart';

// about_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'about_state.dart'; // Make sure this file contains the AboutCubitState class

class AboutCubit extends Cubit<AboutCubitState> {
  AboutCubit() : super(const AboutCubitState());

  void updateMessage(String newMessage) {
    emit(AboutCubitState(message: newMessage));
  }
}
