import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/usecase/getuser_infirestore.dart';

part 'getrole_state.dart';

class GetRoleCubit extends Cubit<UserState> {
  GetRoleCubit(
    this._getUserInFirestore,
  ) : super(UserInitial());
  final GetUserInFirestore _getUserInFirestore;
  void getUserInFirestore(String email) async {
    emit(UserLoading());
    final user = await _getUserInFirestore(email);
    if (user.role == 'superadmin') {
      emit(SuperAdmin(user: user));
    } else if (user.role == 'officer') {
      emit(Officer(user: user));
    } else if (user.role == 'collector') {
      emit(Collector(user: user));
    } else if (user.role == 'user') {
      emit(FirestoreUser(user: user));
    }
  }
}
