



import 'package:rakibsk/repostiroy/user_repository.dart';

class RegisterViewModel {
  final UserRepository repository;

  RegisterViewModel(this.repository);

  Future<void> login(String email, String password) {
    return repository.loginUser(email, password);
  }
}
