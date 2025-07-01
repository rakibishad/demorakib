import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakibsk/repostiroy/user_repository.dart';
import 'package:rakibsk/screen/registerstion_Screen/cubit/state_cubit.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_model.dart';
import '../../../repostiroy/user_repository.dart';
import 'state_cubit.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final token = await repository.loginUser(email, password);

      // ✅ Save token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', token);

      emit(LoginSuccess(token));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}