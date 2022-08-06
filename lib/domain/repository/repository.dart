import '../entity/house_record_entity.dart';
import '../entity/suggestion_entity.dart';
import '../entity/user_entity.dart';

abstract class Repository {
  Future<void> addHouseData(HouseRecordEntity house);
  Stream<List<HouseRecordEntity>> getHouses(String phase);
  Stream<List<HouseRecordEntity>> searchPayment(String address);
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Future<void> addUser(UserEntity user);
  Future<void> register(String email, String password);
  Future<void> updateHouse(String uid, HouseRecordEntity house);
  Future<void> addSuggestion(SuggestionEntity suggestion);
  Future<UserEntity> getUserInFirestore(String email);
  Stream<List<UserEntity>> getUserAccounts();
  Future<void> createUserAccount(UserEntity user);
  Future<void> addHistory(HouseRecordEntity house);
  Future<List<HouseRecordEntity>> getHistory();
  Future<void> deleteHistory(String address);
  Future<List<HouseRecordEntity>> searchHistory(String query);
}
