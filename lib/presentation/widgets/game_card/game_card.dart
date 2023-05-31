import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/general_navigator.dart';
import '../../../core/framework/util/util.dart';
import '../../../domain/entities/deal_info.dart';
import '../../screens/game_detail/game_detail_screen.dart';
import '../steam_pill/steam_pill.dart';

class GameCard extends StatefulWidget {
  final DealInfo deal;

  const GameCard({
    super.key,
    required this.deal,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  final Color _footerColor = const Color(0xFF09070C);
  final double _footerHeight = 90;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToInfo(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.deal.salePrice == 0 ? ThemeManager.kSecondaryColor : ThemeManager.kPrimaryLightColor.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                _buildCoverImage(
                  widget.deal.coverImage,
                  showBlur: widget.deal.steamAppID == null,
                ),
                if (widget.deal.steamAppID != null)
                  Positioned(
                    left: 10,
                    top: 10,
                    child: SteamPill(
                      isSteam: widget.deal.steamAppID != null && widget.deal.storeID == 1,
                    ),
                  ),
                _buildPrice(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: _footerColor,
              ),
              height: _footerHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTitle(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStoreImage(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildShareButton(widget.deal.dealUrl),
                                // SimpleButton(
                                //   height: 38,
                                //   style: SimpleButonStyle.tuki,
                                //   text: Util.getGreenButtonName(widget.deal.salePrice),
                                //   margin: const EdgeInsets.only(bottom: 5),
                                //   onTap: () async => Util.openUrl(widget.deal.dealUrl),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(221, 15, 21, 24),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.deal.savings != 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: widget.deal.salePrice == 0 ? 5 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.deal.salePrice == 0 ? Localization.xGameCard.free : "${widget.deal.savings.toStringAsFixed(0)}% OFF",
                      style: TextStyle(
                        color: ThemeManager.kSecondaryColor,
                        fontSize: widget.deal.salePrice == 0 ? 24 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$ ${widget.deal.normalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.wavy,
                        decorationColor: ThemeManager.kPrimaryColor,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.deal.salePrice != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: widget.deal.savings == 0 ? 15 : 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.7),
                  borderRadius: widget.deal.savings == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                        )
                      : null,
                ),
                child: Text(
                  "\$ ${widget.deal.salePrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: widget.deal.savings == 0 ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 8,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Flexible _buildTitle() {
    return Flexible(
      child: TextScroll(
        widget.deal.title,
        delayBefore: const Duration(seconds: 2),
        pauseBetween: const Duration(seconds: 5),
        fadeBorderSide: FadeBorderSide.right,
        selectable: true,
        velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
        intervalSpaces: 25,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: ThemeManager.kSecondaryFont,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Padding _buildStoreImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: CachedNetworkImage(
        imageUrl: "https://www.cheapshark.com/img/stores/banners/${widget.deal.storeID - 1}.png",
        height: 24,
        filterQuality: FilterQuality.low,
      ),
    );
  }

  void _createTinyUrl(String dealUrl) {
    Uri uri = Uri.parse("https://tinyurl.com/api-create.php?url=$dealUrl");
    http.post(uri).then((response) {
      if (response.statusCode == 200) {
        Share.share(
          Localization.xGameCard.share(
            title: widget.deal.title,
            link: response.body,
          ),
        );
      }
    });
  }

  Tooltip _buildShareButton(String dealUrl) {
    return Tooltip(
      verticalOffset: -55,
      message: Localization.xCommon.share,
      child: MaterialButton(
        padding: const EdgeInsets.all(8),
        minWidth: 0,
        height: 40,
        shape: const CircleBorder(),
        onPressed: () => _createTinyUrl(dealUrl),
        child: const Icon(
          FontAwesomeIcons.shareNodes,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _getImageBuilder({
    required ImageProvider<Object> imageProvider,
    required bool showBlur,
  }) {
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          color: Colors.white12,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        if (showBlur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
      ],
    );
  }

  ClipRRect _buildCoverImage(String imageUrl, {bool showBlur = false}) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CachedNetworkImage(
        height: 160,
        imageUrl: imageUrl,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
        imageBuilder: (context, imageProvider) {
          return _getImageBuilder(
            imageProvider: imageProvider,
            showBlur: showBlur,
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: ThemeManager.kSecondaryColor40,
                color: ThemeManager.kSecondaryColor90,
                value: progress.progress,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return widget.deal.steamAppID != null
              ? _getImageBuilder(
                  imageProvider: CachedNetworkImageProvider(widget.deal.thumb),
                  showBlur: true,
                )
              : Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.white10,
                  child: const Icon(
                    FontAwesomeIcons.image,
                    size: 96,
                    color: Colors.white10,
                  ),
                );
        },
      ),
    );
  }

  void _goToInfo() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (widget.deal.steamAppID != null) {
      GeneralNavigator.push(
        GameDetailScreen(deal: widget.deal),
      );
    } else {
      Util.openUrl(widget.deal.dealUrl);
    }
  }
}
