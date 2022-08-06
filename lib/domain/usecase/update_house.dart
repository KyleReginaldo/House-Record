import '../entity/house_record_entity.dart';
import '../repository/repository.dart';

class UpdateHouse {
  final Repository repo;
  UpdateHouse({
    required this.repo,
  });

  Future<void> call(String uid, HouseRecordEntity house) async {
    await repo.updateHouse(uid, house);
  }
}
