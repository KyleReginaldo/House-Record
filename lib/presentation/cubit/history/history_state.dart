// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryCubitInitial extends HistoryState {}

class Loading extends HistoryState {}

class Loaded extends HistoryState {
  final List<HouseRecordEntity> history;
  Loaded({required this.history});
}

class Empty extends HistoryState {}
