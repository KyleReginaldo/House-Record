import '../entity/user_entity.dart';
import '../repository/repository.dart';

class GetUserInFirestore {
  final Repository repo;
  GetUserInFirestore({
    required this.repo,
  });

  Future<UserEntity> call(String email) async {
    return await repo.getUserInFirestore(email);
  }
}
