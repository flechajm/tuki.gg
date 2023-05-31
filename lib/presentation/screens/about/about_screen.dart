import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/framework/localization/localization.dart';
import '../../../core/framework/theme/theme_manager.dart';
import '../../../core/framework/util/util.dart';
import '../../widgets/common/cool_app_bar/cool_app_bar.dart';
import '../../widgets/common/text_link/text_link.dart';
import '../../widgets/tuki_logo/tuki_logo.dart';

class AboutScreen extends StatelessWidget {
  final String version;

  const AboutScreen({
    super.key,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoolAppBar(
        title: Localization.xAbout.title,
        showBackButton: true,
        showLogo: false,
        showActionButtons: false,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TukiLogo(),
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 20),
                child: Text(
                  "${Localization.xAbout.version} $version",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                "${Localization.xAbout.madeIn}\n${Localization.xAbout.copyright}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Divider(
                color: Colors.white12,
                indent: 80,
                endIndent: 80,
                height: 80,
              ),
              _buildAuthor(
                title: Localization.xAbout.developedBy,
                author: "Juan Manuel Flecha",
                link: "https://flechajm.github.io",
              ),
              const SizedBox(height: 50),
              _buildAuthor(
                title: Localization.xAbout.poweredBy,
                author: "CheapShark API",
                link: "https://www.cheapshark.com",
              ),
              const Expanded(
                child: FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  size: 64,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildAuthor({
    required String title,
    required String author,
    required String link,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: TextLink(
                author,
                onTap: () => Util.openUrl(link),
                textDecorationStyle: TextDecorationStyle.dotted,
                style: TextStyle(
                  fontSize: 18,
                  color: ThemeManager.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(
              FontAwesomeIcons.upRightFromSquare,
              size: 12,
              color: Colors.white70,
            ),
          ],
        )
      ],
    );
  }
}
