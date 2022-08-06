// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:house_record/domain/repository/repository.dart';

class DeleteHistory {
  final Repository repo;
  DeleteHistory({required this.repo});
  Future<void> call(String address) async {
    await repo.deleteHistory(address);
  }
}
