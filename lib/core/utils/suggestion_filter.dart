import 'package:hive/hive.dart';
import '../../data/model/suggestion_model.dart';

class SuggestionFilter {
  final suggestionBox = Hive.box('Suggestions_edited');
  Future<List<SuggestionModel>> showSuggestions(String query) async {
    var cachedReceipt = suggestionBox.values.toList();
    final convertedTable = cachedReceipt.map((e) {
      return SuggestionModel.fromEntity(e);
    }).toList();
    List<SuggestionModel> matches = [];
    matches.addAll(convertedTable);
    matches.retainWhere((element) =>
        element.address.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
