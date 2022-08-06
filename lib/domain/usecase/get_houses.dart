import '../entity/house_record_entity.dart';
import '../repository/repository.dart';

class GetHouses {
  final Repository repo;
  GetHouses({
    required this.repo,
  });

  Stream<List<HouseRecordEntity>> call(String phase) {
    return repo.getHouses(phase);
  }
}
