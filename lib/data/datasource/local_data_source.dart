import 'package:hive/hive.dart';
import '../model/suggestion_model.dart';

import '../model/house_record_model.dart';

abstract class LocalDataSource {
  Future<void> addSuggestion(SuggestionModel suggestion);
  Future<void> addHistory(HouseRecordModel house);
  Future<List<HouseRecordModel>> getHistory();
  Future<void> deleteHistory(String address);
  Future<List<HouseRecordModel>> searchHistory(String query);
}

class LocalDataSourceImpl implements LocalDataSource {
  final suggestionBox = Hive.box('Suggestions_edited');
  final historyBox = Hive.box('HistoryRecord');
  @override
  Future<void> addSuggestion(SuggestionModel suggestion) async {
    await suggestionBox.put(suggestion.address, suggestion);
  }

  @override
  Future<void> addHistory(HouseRecordModel house) async {
    await historyBox.put(house.ownerName, house);
  }

  @override
  Future<List<HouseRecordModel>> getHistory() async {
    var boxList = historyBox.values.toList();
    final historyTable = boxList.map((e) {
      return e as HouseRecordModel;
    }).toList();
    return historyTable;
  }

  @override
  Future<void> deleteHistory(String ownername) async {
    await historyBox.delete(ownername);
  }

  @override
  Future<List<HouseRecordModel>> searchHistory(String query) async {
    var boxList = historyBox.values.toList();
    final historyTable = boxList.map((e) {
      return HouseRecordModel.fromEntity(e);
    }).toList();
    final result = historyTable.where((element) {
      final address = element.address.toLowerCase();
      return address.contains(query.toLowerCase());
    }).toList();
    return result;
  }
}
