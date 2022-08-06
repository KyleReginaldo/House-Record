// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:house_record/domain/usecase/delete_history.dart';
import 'package:meta/meta.dart';

import 'package:house_record/domain/entity/house_record_entity.dart';
import 'package:house_record/domain/usecase/get_history.dart';

import '../../../domain/entity/suggestion_entity.dart';
import '../../../domain/usecase/add_history.dart';
import '../../../domain/usecase/add_suggestion.dart';
import '../../../domain/usecase/search_history.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistory _get;
  final AddHistory _add;
  final DeleteHistory _del;
  final AddSuggestion _addSuggestion;
  final SearchHistory _search;
  HistoryCubit(
    this._get,
    this._add,
    this._del,
    this._addSuggestion,
    this._search,
  ) : super(HistoryCubitInitial());

  void getHistory() async {
    emit(Loading());

    var history = await _get();
    if (history.isEmpty) {
      emit(Empty());
    } else {
      emit(Loaded(history: history));
    }
  }

  void addHistory(HouseRecordEntity house) async {
    await _add(house);
  }

  void deleteHistory(String address) async {
    await _del(address);
  }

  void addSuggestion(SuggestionEntity suggestion) async {
    await _addSuggestion(suggestion);
  }

  void searchHistory(String query) async {
    emit(Loading());
    final history = await _search.call(query);
    if (history.isEmpty) {
      emit(Empty());
    } else {
      emit(Loaded(history: history));
    }
  }
}
