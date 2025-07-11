abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String email;
  LoginSuccess(this.email);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
