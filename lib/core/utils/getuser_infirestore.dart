import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/user_model.dart';

Future<UserModel> getUserInFirestore(String email) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(email).get();

  return UserModel.fromMap(userDoc.data() ?? {'': ''});
}
