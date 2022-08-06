part of 'house_cubit.dart';

@immutable
abstract class HouseState {}

class HouseInitial extends HouseState {}

class Loaded extends HouseState {
  final List<HouseRecordEntity> houses;
  Loaded({
    required this.houses,
  });
}

class Loading extends HouseState {}

class Error extends HouseState {}

class Empty extends HouseState {
  final String msg;
  Empty(
    this.msg,
  );
}
