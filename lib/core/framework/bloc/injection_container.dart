import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/datasources/deals_datasource.dart';
import '../../../data/datasources/steam_game_datasource.dart';
import '../../../data/datasources/stores_datasource.dart';
import '../../../data/repositories/deals_repository.dart';
import '../../../data/repositories/steam_game_repository.dart';
import '../../../data/repositories/stores_repository.dart';
import '../../../domain/repositories/ideals_repository.dart';
import '../../../domain/repositories/isteam_game_repository.dart';
import '../../../domain/repositories/istores_repository.dart';
import '../../../domain/usecases/deal_info/get_deals.dart';
import '../../../domain/usecases/steam_game/get_steam_game.dart';
import '../../../domain/usecases/stores/get_stores.dart';
import '../../../presentation/cubit/deals/deals_cubit.dart';
import '../../../presentation/cubit/steam_game/steam_game_cubit.dart';
import '../../../presentation/cubit/stores/store_cubit.dart';
import '../../http/http_client.dart';
import '../../network/network_info.dart';

/// Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Cubit
  sl.registerFactory(() => DealsCubit(sl()));
  sl.registerFactory(() => SteamGameCubit(sl()));
  sl.registerFactory(() => StoresCubit(sl()));

  //! Use Cases

  //* UseCase
  sl.registerLazySingleton(() => GetDeals(sl()));
  sl.registerLazySingleton(() => GetSteamGame(sl()));
  sl.registerLazySingleton(() => GetStores(sl()));

  //! Repositories
  sl.registerLazySingleton<IDealsRepository>(() => DealsRepository(dataSource: sl()));
  sl.registerLazySingleton<ISteamGameRepository>(() => SteamGameRepository(dataSource: sl()));
  sl.registerLazySingleton<IStoresRepository>(() => StoresRepository(dataSource: sl()));

  //! DataSources
  sl.registerLazySingleton(() => DealsDataSource(client: sl()));
  sl.registerLazySingleton(() => SteamGameDataSource(client: sl()));
  sl.registerLazySingleton(() => StoresDataSource(client: sl()));

  //! Core
  sl.registerLazySingleton(() => HttpClient(client: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => NetworkInfo(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
