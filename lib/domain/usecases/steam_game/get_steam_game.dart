import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/usecase/iusecase.dart';
import '../../entities/steam_game.dart';
import '../../repositories/isteam_game_repository.dart';

class GetSteamGame implements IUseCase<SteamGame, int> {
  final ISteamGameRepository _repository;

  GetSteamGame(this._repository);

  @override
  Future<Either<Failure, SteamGame>> call(appId) async {
    return await _repository.getSteamGame(appId);
  }
}
