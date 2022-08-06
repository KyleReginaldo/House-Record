import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/house_record_model.dart';
import '../model/user_model.dart';

abstract class RemoteDataSource {
  Future<void> addHouseData(HouseRecordModel house);
  Stream<List<HouseRecordModel>> getHouses(String phase);
  Stream<List<HouseRecordModel>> searchPayment(String address);
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Future<void> addUser(UserModel user);
  Future<void> register(String email, String password);
  Future<void> updateHouse(String uid, HouseRecordModel house);
  Future<UserModel> getUserInFirestore(String email);
  Stream<List<UserModel>> getUserAccounts();
  Future<void> createUserAccount(UserModel user);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<void> addHouseData(HouseRecordModel house) async {
    final docHouse = FirebaseFirestore.instance.collection('houses').doc();
    house.uid = docHouse.id;
    await docHouse.set(house.toMap());
  }

  @override
  Stream<List<HouseRecordModel>> getHouses(String phase) {
    return FirebaseFirestore.instance
        .collection('houses')
        .where('phase', isEqualTo: phase)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HouseRecordModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Stream<List<HouseRecordModel>> searchPayment(String address) {
    return FirebaseFirestore.instance
        .collection('houses')
        .where('address', isEqualTo: address.toLowerCase())
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => HouseRecordModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Future<void> logIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> addUser(UserModel user) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc();
    await userDoc.set(user.toMap());
  }

  @override
  Future<void> register(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> updateHouse(String uid, HouseRecordModel house) async {
    final docHouse = FirebaseFirestore.instance.collection('houses').doc(uid);
    house.uid = docHouse.id;
    await docHouse.update(house.toMap());
  }

  @override
  Future<UserModel> getUserInFirestore(String email) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    return UserModel.fromMap(userDoc.data() ?? {'': ''});
  }

  @override
  Stream<List<UserModel>> getUserAccounts() {
    return FirebaseFirestore.instance.collection('users').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
  }

  @override
  Future<void> createUserAccount(UserModel user) async {
    final currentUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.user?.email ?? 'na')
        .set(user.toMap());
  }
}
