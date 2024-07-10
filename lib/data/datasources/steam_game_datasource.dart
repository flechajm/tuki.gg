import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

import '../../core/errors/exceptions/server_exception.dart';
import '../../core/framework/localization/localization.dart';
import '../../core/framework/util/app_settings.dart';
import '../models/steam_game/steam_game_model.dart';
import 'base/datasource.dart';
import 'interfaces/isteam_game_datasource.dart';

class SteamGameDataSource extends DataSource implements ISteamGameDataSource {
  final String _endpoint = GlobalConfiguration().getDeepValue("api:endpoints:steamGame");

  SteamGameDataSource({
    required super.client,
  });

  @override
  Future<SteamGameModel> getSteamGame(int appId) async {
    String fixedEndpoint = _endpoint
        .replaceAll("{appId}", appId.toString())
        .replaceAll("{cc}", AppSettings.currency)
        .replaceAll("{lang}", AppSettings.gameLanguages[AppSettings.gameDataLang]!);

    String data = await client.get(
      url: fixedEndpoint,
    );

    bool success = json.decode(data)[appId.toString()]["success"];
    if (!success) throw ServerException(code: 1, message: Localization.xErrors.fail);

    return SteamGameModel.fromJson(json.decode(data)[appId.toString()]["data"]);
  }
}
