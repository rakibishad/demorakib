import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rakibsk/screen/splashScreen/splashUi/splash_form.dart';

import '../splashCubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<SplashCubit>(
      create: (BuildContext context) => SplashCubit(),
      child: const SplashScreen(),
    );
  }
}