import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/steam_game.dart';

abstract class ISteamGameRepository {
  Future<Either<Failure, SteamGame>> getSteamGame(int appId);
}
