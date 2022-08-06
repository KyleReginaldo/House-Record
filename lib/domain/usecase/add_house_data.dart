import '../entity/house_record_entity.dart';
import '../repository/repository.dart';

class AddHouseData {
  final Repository repo;
  AddHouseData({
    required this.repo,
  });

  Future<void> call(HouseRecordEntity house) async {
    await repo.addHouseData(house);
  }
}
