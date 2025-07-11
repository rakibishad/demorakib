import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(userCredential.user?.email ?? "No Email"));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.message ?? "Login failed"));
    } catch (e) {
      emit(LoginError("Unexpected error: $e"));
    }
  }

  String? emailChanged(String? email) {
    if (email == null || email.isEmpty) return "Email can't be empty";
    if (!email.contains('@')) return "Enter a valid email";
    return null;
  }

  String? passwordChanged(String? password) {
    if (password == null || password.length < 6) return "Password too short";
    return null;
  }
}
