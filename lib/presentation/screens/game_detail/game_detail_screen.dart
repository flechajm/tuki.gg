import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/framework/bloc/injection_container.dart';
import '../../../core/framework/extensions/datetime/datetime_extensions.dart';
import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/app_settings.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../core/framework/util/util.dart';
import '../../../domain/entities/deal_info.dart';
import '../../../domain/entities/steam_game.dart';
import '../../cubit/steam_game/steam_game_cubit.dart';
import '../../widgets/common/center_circle_loading/center_circle_loading.dart';
import '../../widgets/common/cool_app_bar/cool_app_bar.dart';
import '../../widgets/common/simple_button/simple_button.dart';
import '../../widgets/common/simple_scroll/simple_scroll.dart';
import '../../widgets/error_message/error_message.dart';
import '../../widgets/external_card/external_card.dart';
import 'widgets/row_info.dart';

class GameDetailScreen extends StatelessWidget {
  final DealInfo deal;

  const GameDetailScreen({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CoolAppBar(
        showLogo: false,
        showBackButton: true,
        showActionButtons: false,
      ),
      body: BlocProvider<SteamGameCubit>(
        create: (context) {
          if (deal.steamAppID != null) {
            return sl<SteamGameCubit>()..getSteamGame(deal.steamAppID!);
          } else {
            return sl<SteamGameCubit>();
          }
        },
        child: BlocBuilder<SteamGameCubit, SteamGameState>(
          builder: (context, state) {
            if (state is SteamGameInitial || state is SteamGameLoading) {
              return const CenterCircleLoading();
            } else if (state is SteamGameLoaded) {
              SteamGame steamGame = state.steamGameResponse;
              return _buildBody(steamGame);
            } else if (state is SteamGameError) {
              return ErrorMessage(
                image: "assets/images/general/empty_results.json",
                text: state.failure.message,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SimpleButton(
                      text: Localization.xCommon.back,
                      style: SimpleButonStyle.secondary,
                      onTap: () => GeneralNavigator.pop(),
                    ),
                    const SizedBox(height: 10),
                    SimpleButton(
                      text: Localization.xCommon.goToStore,
                      onTap: () => Util.openUrl(deal.dealUrl),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildBody(SteamGame steamGame) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CachedNetworkImage(
          imageUrl: steamGame.backgroundImage,
          fit: BoxFit.fitWidth,
          imageBuilder: (context, imageProvider) {
            return Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    ThemeManager.kBackgroundColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.3],
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            );
          },
          errorWidget: (context, url, error) => const SizedBox.shrink(),
        ),
        Padding(
          padding: EdgeInsets.only(top: Util.sizeAppBar.height + 30),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SimpleScroll(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      deal.title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          CachedNetworkImage(imageUrl: deal.coverImage),
                          Container(
                            color: Colors.black38,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    steamGame.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  if (AppSettings.showExtendedInfo) _buildExtendedInfo(steamGame),
                                  const Divider(color: Colors.white70),
                                  _buildPriceDetails(steamGame),
                                  SimpleButton(
                                    text: Util.getGreenButtonName(deal.salePrice),
                                    onTap: () async => Util.openUrl(deal.dealUrl),
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 10),
                                    style: SimpleButonStyle.tuki,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (AppSettings.showSteamReviews && deal.steamRatingText != null) _buildSteamReviews(steamGame),
                  if (AppSettings.showMetacriticScore && deal.metacriticScore != null && deal.metacriticScore! > 0) _buildMetacriticScore(),
                  if (AppSettings.showSteamAchievements && steamGame.achievements != null) _buildSteamAchievements(steamGame),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPriceDetails(SteamGame steamGame) {
    final bool otherCurrency = AppSettings.currency != "us";
    final bool isSteam = deal.storeID == 1 && otherCurrency;
    final bool hasDiscount = deal.savings != 0;

    final String normalPrice = isSteam
        ? steamGame.normalPrice!
        : NumberFormat.currency(
            locale: "en_US",
            symbol: "\$ ",
          ).format(deal.normalPrice);

    final String finalPrice = isSteam
        ? steamGame.salePrice!
        : NumberFormat.currency(
            locale: "en_US",
            symbol: "\$ ",
          ).format(deal.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSteam && otherCurrency)
          Row(
            children: [
              Text(
                Localization.xGameDetail.xPrices.priceUSD,
                textAlign: TextAlign.end,
              ),
              const Expanded(
                child: Divider(
                  color: Colors.white24,
                  indent: 5,
                  endIndent: 5,
                  height: 0,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: "en_US",
                  customPattern: "\$ #",
                ).format(deal.normalPrice),
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        if (hasDiscount)
          Row(
            children: [
              Text(
                Localization.xGameDetail.xPrices.normalPrice,
                textAlign: TextAlign.end,
              ),
              const Expanded(
                child: Divider(
                  color: Colors.white24,
                  indent: 5,
                  endIndent: 5,
                  height: 0,
                ),
              ),
              Text(
                normalPrice,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        if (hasDiscount)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Localization.xGameDetail.xPrices.discount,
                textAlign: TextAlign.end,
              ),
              const Expanded(
                child: Divider(
                  color: Colors.white24,
                  indent: 5,
                  endIndent: 5,
                  height: 0,
                ),
              ),
              Text(
                "${deal.savings.toStringAsFixed(0)}%",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeManager.kSecondaryColor,
                ),
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hasDiscount ? Localization.xGameDetail.xPrices.finalPrice : "Precio localizado:",
              textAlign: TextAlign.end,
            ),
            const Expanded(
              child: Divider(
                color: Colors.white24,
                indent: 5,
                endIndent: 5,
                height: 0,
              ),
            ),
            Text(
              finalPrice,
              style: TextStyle(
                color: ThemeManager.kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Padding _buildSteamAchievements(SteamGame steamGame) {
    const double squareSize = 72;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ExternalCard(
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  Localization.xGameDetail.includeAchievements(total: steamGame.achievements!.total),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...steamGame.achievements!.highlighted.map((e) {
                    return Tooltip(
                      showDuration: const Duration(milliseconds: 2500),
                      triggerMode: TooltipTriggerMode.tap,
                      verticalOffset: -75,
                      message: e.name,
                      child: Container(
                        height: squareSize,
                        width: squareSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey.withAlpha(100),
                            width: 1,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: e.path,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    );
                  }),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      splashColor: Colors.blueGrey.withAlpha(50),
                      highlightColor: Colors.transparent,
                      onTap: () => Util.openUrl("https://steamcommunity.com/stats/${steamGame.appId}/achievements"),
                      child: Container(
                        height: squareSize,
                        width: squareSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey.withAlpha(150),
                            width: 1,
                          ),
                          color: Colors.black12,
                        ),
                        child: Text(
                          Localization.xGameDetail.viewAllAchievements,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildMetacriticScore() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ExternalCard(
        onTap: deal.metacriticLink != null ? () => Util.openUrl("https://www.metacritic.com${deal.metacriticLink!}") : null,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _getMetacriticColorReview(),
              ),
              child: Text(
                deal.metacriticScore.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "metacritic",
              style: TextStyle(
                fontFamily: ThemeManager.kPrimaryFont,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSteamReviews(SteamGame steamGame) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ExternalCard(
        onTap: () => Util.openUrl("https://steamcommunity.com/app/${steamGame.appId}/reviews/"),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "${deal.steamRatingPercent!.toStringAsFixed(0)}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    color: _getSteamColorReview(),
                    backgroundColor: _getSteamColorReview().withAlpha(100),
                    strokeWidth: 6,
                    value: deal.steamRatingPercent! / 100,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppSettings.appLang == "en-US" ? deal.steamRatingText! : _getLocalizationReview(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _getSteamColorReview(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    Localization.xGameDetail.xSteamReviews.description(
                      percent: deal.steamRatingPercent!,
                      total: deal.steamRatingCount!,
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white24,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    Localization.xGameDetail.xSteamReviews.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getMetacriticColorReview() {
    if (deal.metacriticScore! >= 75 && deal.metacriticScore! <= 100) {
      return const Color(0xFF66CC33);
    } else if (deal.metacriticScore! >= 50 && deal.metacriticScore! <= 74) {
      return const Color(0xFFffcc33);
    } else {
      return const Color(0xFFFF0000);
    }
  }

  Color _getSteamColorReview() {
    switch (deal.steamRatingText) {
      case "Overwhelmingly Positive":
        return Colors.blueAccent[700]!;
      case "Very Positive":
        return Colors.blueAccent[400]!;
      case "Positive":
      case "Mostly Positive":
        return Colors.blue[400]!;

      case "Mixed":
        return Colors.orangeAccent[400]!;

      case "Mostly Negative":
      case "Very Negative":
      case "Overwhelmingly Negative":
        return Colors.redAccent[400]!;

      default:
        return Colors.white;
    }
  }

  String _getLocalizationReview() {
    switch (deal.steamRatingText) {
      case "Overwhelmingly Positive":
        return Localization.xGameDetail.xSteamReviews.overwhelminglyPositive;
      case "Very Positive":
        return Localization.xGameDetail.xSteamReviews.veryPositive;
      case "Positive":
        return Localization.xGameDetail.xSteamReviews.positive;
      case "Mostly Positive":
        return Localization.xGameDetail.xSteamReviews.mostlyPositive;
      case "Mixed":
        return Localization.xGameDetail.xSteamReviews.mixed;
      case "Mostly Negative":
        return Localization.xGameDetail.xSteamReviews.mostlyNegative;
      case "Very Negative":
        return Localization.xGameDetail.xSteamReviews.veryNegative;
      case "Overwhelmingly Negative":
        return Localization.xGameDetail.xSteamReviews.overwhelminglyNegative;

      default:
        return "";
    }
  }

  Widget _buildExtendedInfo(SteamGame steamGame) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (steamGame.categories != null)
            RowInfo(
              text: Localization.xGameDetail.categories,
              value: steamGame.categories!.join(", "),
            ),
          if (steamGame.genres != null)
            RowInfo(
              text: Localization.xGameDetail.genres,
              value: steamGame.genres!.join(", "),
            ),
          if (steamGame.developers != null)
            RowInfo(
              text: Localization.xGameDetail.developer,
              value: steamGame.publishers!.join(", "),
            ),
          if (steamGame.publishers != null)
            RowInfo(
              text: Localization.xGameDetail.publisher,
              value: steamGame.publishers!.join(", "),
            ),
          if (deal.releaseDate != null)
            RowInfo(
              text: Localization.xGameDetail.releaseDate,
              value: DateTime.fromMillisecondsSinceEpoch(deal.releaseDate! * 1000).largeDate(convertToLocal: false),
            ),
        ],
      ),
    );
  }
}
