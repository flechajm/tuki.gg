import '../../../domain/entities/steam_game.dart';

abstract class ISteamGameDataSource {
  Future<SteamGame> getSteamGame(int appId);
}
