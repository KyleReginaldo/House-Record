// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:house_record/domain/entity/house_record_entity.dart';
import 'package:house_record/domain/repository/repository.dart';

class AddHistory {
  final Repository repo;
  AddHistory({required this.repo});

  Future<void> call(HouseRecordEntity house) async {
    await repo.addHistory(house);
  }
}
