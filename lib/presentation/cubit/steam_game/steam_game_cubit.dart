import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/cubit/cubit_base.dart';
import '../../../domain/entities/steam_game.dart';
import '../../../domain/usecases/steam_game/get_steam_game.dart';

part 'steam_game_state.dart';

class SteamGameCubit extends CubitBase<SteamGame, SteamGameState> {
  final GetSteamGame _getSteamGame;

  SteamGameCubit(this._getSteamGame) : super(SteamGameInitial());

  void getSteamGame(int appId) async {
    emit(SteamGameLoading());
    final eitherData = await _getSteamGame(appId);
    if (isClosed) return;
    emit(getState(eitherData));
  }

  @override
  SteamGameState getState(Either<Failure, SteamGame> eitherData) {
    return eitherData.fold(
      (failure) => SteamGameError(failure),
      (data) => SteamGameLoaded(data),
    );
  }
}
