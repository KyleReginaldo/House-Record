import '../entity/user_entity.dart';
import '../repository/repository.dart';

class CreateUserAccount {
  final Repository repo;
  CreateUserAccount({
    required this.repo,
  });

  Future<void> call(UserEntity user) async {
    await repo.createUserAccount(user);
  }
}
