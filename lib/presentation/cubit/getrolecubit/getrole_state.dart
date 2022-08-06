part of 'getrole_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class SuperAdmin extends UserState {
  final UserEntity user;
  SuperAdmin({required this.user});
}

class Officer extends UserState {
  final UserEntity user;
  Officer({required this.user});
}

class Collector extends UserState {
  final UserEntity user;
  Collector({required this.user});
}

class UserLoading extends UserState {}

class FirestoreUser extends UserState {
  final UserEntity user;
  FirestoreUser({required this.user});
}
