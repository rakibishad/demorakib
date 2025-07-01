import 'package:flutter_bloc/flutter_bloc.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplashTimer() {
    // Simulate delay (e.g., check session or do something async)
    Timer(const Duration(seconds: 5), () {
      // Navigate based on your condition
      emit(SplashNavigateToHome()); // You can replace this with logic
    });
  }
}
