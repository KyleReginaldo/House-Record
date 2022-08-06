import '../entity/user_entity.dart';
import '../repository/repository.dart';

class GetUserAccounts {
  final Repository repo;
  GetUserAccounts({
    required this.repo,
  });

  Stream<List<UserEntity>> call() {
    return repo.getUserAccounts();
  }
}
