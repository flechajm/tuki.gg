import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExternalCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ExternalCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xDD15151F),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 4,
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              child,
              if (onTap != null)
                const Icon(
                  FontAwesomeIcons.upRightFromSquare,
                  size: 14,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
