import '../repository/repository.dart';

class LogOut {
  final Repository repo;
  LogOut({
    required this.repo,
  });

  Future<void> call() async {
    await repo.logOut();
  }
}
