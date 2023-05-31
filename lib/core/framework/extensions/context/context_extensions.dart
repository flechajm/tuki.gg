import 'package:flutter/material.dart';

import '../../util/util.dart';

extension ContextExtensions on BuildContext {
  /// Gets the MediaQueryData of [MediaQuery.of(context)]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Gets the Size of MediaQuery.
  Size get _mediaQuerySize => mediaQuery.size;

  /// Gets the orientation of MediaQuery.
  Orientation get _orientation => mediaQuery.orientation;

  /// Gets the screen height.
  double get height => _mediaQuerySize.height;

  /// Gets the screen width.
  double get width => _mediaQuerySize.width;

  /// Gets the viewInsets of MediaQuery.
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Gets the viewPadding of MediaQuery.
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  /// Gets the padding of MediaQuery.
  EdgeInsets get padding => mediaQuery.padding;

  /// Checks if the device's orientation is on landscape.
  bool get isLandscape => _orientation == Orientation.landscape;

  /// Checks if the device's orientation is on portrait.
  bool get isPortrait => _orientation == Orientation.portrait;

  /// Adjusts the height of the screen divided by a number.
  ///
  /// The [dividedBy] number represents the percent to resize the screen, `beign 1 = 100%`
  /// without resizing.
  ///
  /// For example:
  /// ```dart
  /// SizedBox(
  ///   height: context.adjustHeight(dividedBy: 1.5),
  ///   width: double.infinity,
  ///   child: MyScreen(),
  /// ),
  /// ```
  /// Subtracts `50%` from the total height of the screen, so the
  /// resulting height of the [SizedBox] will be `50%`.
  double adjustHeight({double dividedBy = 1}) => _mediaQuerySize.height / dividedBy;

  /// Adjusts the width of the screen divided by a number.
  ///
  /// The [dividedBy] number represents the percent to resize the screen, `beign 1 = 100%`
  /// without resizing.
  ///
  /// For example:
  /// ```dart
  /// SizedBox(
  ///   width: context.adjustWidth(dividedBy: 1.2),
  ///   height: double.infinity,
  ///   child: MyScreen(),
  /// ),
  /// ```
  /// Subtracts `20%` from the total width of the screen, so the
  /// resulting width of the [SizedBox] will be `80%`.
  double adjustWidth({double dividedBy = 1}) => _mediaQuerySize.width / dividedBy;

  /// Adjusts the size of the target according to how much it occupies on the screen.
  ///
  /// The [multiplyBy] number represents the percent that the target will be occupied on the screen,
  /// `beign 1 = 100%` without resizing.
  ///
  ///  For example:
  /// ```dart
  /// SizedBox(
  ///   width: context.blockVertical(multiplyBy: 20),
  ///   height: double.infinity,
  ///   child: MyScreen(),
  /// ),
  /// ```
  /// Subtracts `20%` from the total width of the screen, so the
  /// resulting width of the [SizedBox] will be `80%`.
  double blockVertical({double multiplyBy = 1}) => (_mediaQuerySize.height / 100) * multiplyBy;
  double blockHorizontal({double multiplyBy = 1}) => (_mediaQuerySize.width / 100) * multiplyBy;

  /// Calculates a safe area to work within, substracting the [AppBar] height.
  double calculateSafeArea() => height - getAppBarTotalHeight();

  /// Gets the [AppBar]'s height.
  double getAppBarTotalHeight() => padding.top + Util.sizeAppBar.height;
}
