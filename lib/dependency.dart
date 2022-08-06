import 'package:get_it/get_it.dart';
import 'package:house_record/domain/usecase/delete_history.dart';
import 'package:house_record/domain/usecase/search_history.dart';
import 'package:house_record/presentation/cubit/history/history_cubit.dart';
import 'data/datasource/local_data_source.dart';
import 'data/datasource/remote_data_source.dart';
import 'data/repository_impl/repository_impl.dart';
import 'domain/repository/repository.dart';
import 'domain/usecase/add_history.dart';
import 'domain/usecase/add_house_data.dart';
import 'domain/usecase/add_suggestion.dart';
import 'domain/usecase/add_user.dart';
import 'domain/usecase/create_user_account.dart';
import 'domain/usecase/get_history.dart';
import 'domain/usecase/get_houses.dart';
import 'domain/usecase/getuser_accounts.dart';
import 'domain/usecase/getuser_infirestore.dart';
import 'domain/usecase/login.dart';
import 'domain/usecase/logout.dart';
import 'domain/usecase/register.dart';
import 'domain/usecase/search_payment.dart';
import 'domain/usecase/update_house.dart';
import 'presentation/cubit/getusercubit/getuser_cubit.dart';
import 'presentation/cubit/house/house_cubit.dart';
import 'presentation/cubit/getrolecubit/getrole_cubit.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => HouseCubit(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => GetRoleCubit(sl()));
  sl.registerFactory(() => GetuserCubit(sl(), sl()));
  sl.registerFactory(() => HistoryCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetHistory(repo: sl()));
  sl.registerLazySingleton(() => AddHistory(repo: sl()));
  sl.registerLazySingleton(() => GetHouses(repo: sl()));
  sl.registerLazySingleton(() => DeleteHistory(repo: sl()));
  sl.registerLazySingleton(() => SearchHistory(repo: sl()));
  sl.registerLazySingleton(() => AddHouseData(repo: sl()));
  sl.registerLazySingleton(() => SearchPayment(repo: sl()));
  sl.registerLazySingleton(() => LogIn(repo: sl()));
  sl.registerLazySingleton(() => AddSuggestion(repo: sl()));
  sl.registerLazySingleton(() => LogOut(repo: sl()));
  sl.registerLazySingleton(() => AddUser(repo: sl()));
  sl.registerLazySingleton(() => Register(repo: sl()));
  sl.registerLazySingleton(() => UpdateHouse(repo: sl()));
  sl.registerLazySingleton(() => GetUserAccounts(repo: sl()));
  sl.registerLazySingleton(() => GetUserInFirestore(repo: sl()));
  sl.registerLazySingleton(() => CreateUserAccount(repo: sl()));

  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(remote: sl(), local: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}
