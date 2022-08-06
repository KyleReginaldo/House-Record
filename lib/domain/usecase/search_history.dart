// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:house_record/domain/entity/house_record_entity.dart';
import 'package:house_record/domain/repository/repository.dart';

class SearchHistory {
  final Repository repo;
  SearchHistory({required this.repo});

  Future<List<HouseRecordEntity>> call(String query) async {
    return repo.searchHistory(query);
  }
}
