part of 'getuser_cubit.dart';

@immutable
abstract class GetuserState {}

class GetuserInitial extends GetuserState {}

class AccountLoading extends GetuserState {}

class AccountLoaded extends GetuserState {
  final List<UserEntity> accounts;
  AccountLoaded({
    required this.accounts,
  });
}

class AccountEmpty extends GetuserState {}
