import '../repository/repository.dart';

class LogIn {
  final Repository repo;
  LogIn({
    required this.repo,
  });

  Future<void> call(String email, String password) async {
    await repo.logIn(email, password);
  }
}
