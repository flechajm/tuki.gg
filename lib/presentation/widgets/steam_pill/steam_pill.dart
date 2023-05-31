import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SteamPill extends StatelessWidget {
  final bool isSteam;

  const SteamPill({
    super.key,
    this.isSteam = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 8, bottom: 4, top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: isSteam ? Colors.green[700] : Colors.grey[800],
        border: Border.all(color: isSteam ? Colors.green[900]! : Colors.grey[700]!),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black,
          )
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              FontAwesomeIcons.circleInfo,
              size: 12,
              color: Colors.white,
            ),
          ),
          Text(
            "Steam",
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
