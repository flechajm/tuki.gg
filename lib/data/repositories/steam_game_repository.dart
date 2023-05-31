import 'package:dartz/dartz.dart';

import '../../domain/entities/steam_game.dart';
import '../../domain/repositories/isteam_game_repository.dart';
import '../datasources/steam_game_datasource.dart';
import 'base/repository.dart';

class SteamGameRepository extends Repository<SteamGameDataSource> implements ISteamGameRepository {
  SteamGameRepository({
    required SteamGameDataSource dataSource,
  }) : super(dataSource: dataSource);

  @override
  Future<Either<Failure, SteamGame>> getSteamGame(int appId) async {
    return executeAction<SteamGame>(() async => await dataSource.getSteamGame(appId));
  }
}
