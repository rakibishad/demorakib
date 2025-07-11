
import 'package:rakibsk/screen/about_Screen/about_Ui.dart';

import '../dashBoard_screen/dashboard_state.dart';

// about_state.dart
import 'package:equatable/equatable.dart';

class AboutCubitState extends Equatable {
  final String message;

  const AboutCubitState({this.message = ''});

  @override
  List<Object?> get props => [message];
}
