// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:house_record/domain/entity/house_record_entity.dart';
import 'package:house_record/domain/repository/repository.dart';

class GetHistory {
  final Repository repo;
  GetHistory({required this.repo});

  Future<List<HouseRecordEntity>> call() async {
    return repo.getHistory();
  }
}
