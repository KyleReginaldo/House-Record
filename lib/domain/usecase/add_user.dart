import '../entity/user_entity.dart';
import '../repository/repository.dart';

class AddUser {
  final Repository repo;
  AddUser({
    required this.repo,
  });

  Future<void> call(UserEntity user) async {
    await repo.addUser(user);
  }
}
