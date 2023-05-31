import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String text;
  final String? description;
  final Widget value;

  const Option({
    super.key,
    required this.text,
    this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      height: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (description != null)
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white30,
                        ),
                      ),
                  ],
                ),
                value,
              ],
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.white10,
            ),
          ),
        ],
      ),
    );
  }
}
