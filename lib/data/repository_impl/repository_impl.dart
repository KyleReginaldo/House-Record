import '../datasource/local_data_source.dart';
import '../datasource/remote_data_source.dart';
import '../model/house_record_model.dart';
import '../model/suggestion_model.dart';
import '../model/user_model.dart';
import '../../domain/entity/house_record_entity.dart';
import '../../domain/entity/suggestion_entity.dart';
import '../../domain/entity/user_entity.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remote;
  final LocalDataSource local;
  RepositoryImpl({
    required this.remote,
    required this.local,
  });
  @override
  Future<void> addHouseData(HouseRecordEntity house) async {
    await remote.addHouseData(HouseRecordModel.fromEntity(house));
  }

  @override
  Stream<List<HouseRecordEntity>> getHouses(String phase) {
    try {
      final result = remote.getHouses(phase);
      return result;
    } on Exception {
      rethrow;
    }
  }

  @override
  Stream<List<HouseRecordEntity>> searchPayment(String address) {
    try {
      final result = remote.searchPayment(address);
      return result;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> logIn(String email, String password) async {
    await remote.logIn(email, password);
  }

  @override
  Future<void> logOut() async {
    await remote.logOut();
  }

  @override
  Future<void> addUser(UserEntity user) async {
    await remote.addUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> register(String email, String password) async {
    await remote.register(email, password);
  }

  @override
  Future<void> updateHouse(String uid, HouseRecordEntity house) async {
    await remote.updateHouse(uid, HouseRecordModel.fromEntity(house));
  }

  @override
  Future<void> addSuggestion(SuggestionEntity suggestion) async {
    await local.addSuggestion(SuggestionModel.fromEntity(suggestion));
  }

  @override
  Future<UserEntity> getUserInFirestore(String email) async {
    return await remote.getUserInFirestore(email);
  }

  @override
  Stream<List<UserEntity>> getUserAccounts() {
    try {
      final result = remote.getUserAccounts();
      return result;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> createUserAccount(UserEntity user) async {
    await remote.createUserAccount(UserModel.fromEntity(user));
  }

  @override
  Future<void> addHistory(HouseRecordEntity house) async {
    await local.addHistory(HouseRecordModel.fromEntity(house));
  }

  @override
  Future<List<HouseRecordEntity>> getHistory() async {
    return local.getHistory();
  }

  @override
  Future<void> deleteHistory(String address) async {
    await local.deleteHistory(address);
  }

  @override
  Future<List<HouseRecordEntity>> searchHistory(String query) async {
    return local.searchHistory(query);
  }
}
