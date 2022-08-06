import '../repository/repository.dart';

class Register {
  final Repository repo;
  Register({
    required this.repo,
  });

  Future<void> call(String email, String password) async {
    await repo.register(email, password);
  }
}
