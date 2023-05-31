import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/framework/theme/theme_manager.dart';

class ErrorMessage extends StatelessWidget {
  final String image;
  final String text;
  final Widget child;
  final bool? repeat;

  const ErrorMessage({
    super.key,
    required this.image,
    required this.text,
    required this.child,
    this.repeat,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Lottie.asset(
                    image,
                    repeat: repeat,
                    height: 300,
                    width: 300,
                    filterQuality: FilterQuality.high,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['**', 'decoratio2', '**'],
                          value: ThemeManager.kPrimaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'decoration1', '**'],
                          value: ThemeManager.kSecondaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'shadow', '**'],
                          value: Colors.grey[800],
                        ),
                        ValueDelegate.color(
                          const ['**', 'ball', '**'],
                          value: ThemeManager.kPrimaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'heart Outlines 3', '**'],
                          value: ThemeManager.kPrimaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'heart Outlines 2', '**'],
                          value: ThemeManager.kPrimaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'heart Outlines', '**'],
                          value: ThemeManager.kPrimaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'plus Outlines', '**'],
                          value: ThemeManager.kSecondaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'plus Outlines 2', '**'],
                          value: ThemeManager.kSecondaryColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'bell-bg Outlines', '**'],
                          value: ThemeManager.kBackgroundColor,
                        ),
                        ValueDelegate.color(
                          const ['**', 'z Outlines', '**'],
                          value: ThemeManager.kPrimaryLightColor,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeManager.kFontColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            child,
            // SimpleButton(
            //   text: Localization.xHome.searchAgain,
            //   onTap: () async => context.read<DealsCubit>().getDeals(_paramsDeal),
            // )
          ],
        ),
      ),
    );
  }
}
