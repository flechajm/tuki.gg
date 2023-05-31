part of 'steam_game_cubit.dart';

abstract class SteamGameState {
  const SteamGameState();
}

class SteamGameInitial extends SteamGameState {}

class SteamGameLoading extends SteamGameState {}

class SteamGameLoaded extends SteamGameState {
  final SteamGame steamGameResponse;

  const SteamGameLoaded(this.steamGameResponse);
}

class SteamGameError extends SteamGameState {
  final Failure failure;
  const SteamGameError(this.failure);
}
