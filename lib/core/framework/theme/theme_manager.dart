import 'package:flutter/material.dart';

class ThemeManager {
  //* Fonts

  /// Primary Font
  static String kPrimaryFont = 'Catamaran';

  /// Secondary Font
  static String kSecondaryFont = 'Lato';

  //* Primary Colors

  static Color kFontColor = const Color(0xFF4A4A4A);

  // AppBar title font color
  static Color kAppBarFontColor = const Color(0xFF333333);

  /// Primary Color
  static Color kPrimaryColor = const Color(0xFFCE024D);

  /// Primary Light Color
  static Color kPrimaryLightColor = const Color(0xFFFF3E85);

  /// Primary color with Alpha 90
  static Color kPrimaryColor90 = kPrimaryColor.withAlpha(90);

  /// Primary color with Alpha 40
  static Color kPrimaryColor40 = kPrimaryColor.withAlpha(40);

  //* Secondary Colors

  /// Secondary color
  static Color kSecondaryColor = const Color(0xFF7DE640);

  /// Secondary Light color
  static Color kSecondaryLightColor = const Color(0xFFDAFFC5);

  /// Secondary color with Alpha 90
  static Color kSecondaryColor90 = kSecondaryColor.withAlpha(90);

  /// Secondary color with Alpha 40
  static Color kSecondaryColor40 = kSecondaryColor.withAlpha(40);

  //* Error Colors

  /// Primary Error Color
  static Color kErrorPrimaryColor = Colors.redAccent[400]!;

  /// Error Background Color
  static Color kErrorBackgroundColor = Colors.red[50]!;

  /// Error Border Color
  static Color kErrorBorderColor = Colors.red[100]!.withAlpha(100);

  /// Error FormField Border Color
  static Color kErrorFormFieldBorderColor = Colors.redAccent[200]!;

  //* Other colors

  /// Background color
  static Color kBackgroundColor = const Color(0xFF100C14);

  /// Disabled Color
  static Color kDisabledColor = const Color(0xFF6B7791);

  //* Themes

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      fontFamily: kSecondaryFont,
      scaffoldBackgroundColor: kBackgroundColor,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kSecondaryColor,
        circularTrackColor: kSecondaryColor90,
      ),
      splashColor: kPrimaryColor90,
      highlightColor: kPrimaryColor40,
      unselectedWidgetColor: kPrimaryColor90,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(5, 5),
          ),
          color: kPrimaryColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelPadding: const EdgeInsets.all(8),
        unselectedLabelColor: kPrimaryColor,
        indicator: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(5, 5)),
          color: kPrimaryColor,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          fontFamily: kPrimaryFont,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        contentTextStyle: TextStyle(
          fontFamily: kPrimaryFont,
          fontSize: 14,
          color: Colors.black,
        ),
        actionsPadding: const EdgeInsets.only(bottom: 15, right: 15),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return kPrimaryColor;

          if (states.contains(WidgetState.disabled)) return Colors.white;

          return Colors.grey[100];
        }),
        trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) return kPrimaryColor40;

          if (states.contains(WidgetState.disabled)) return Colors.white;

          return Colors.grey[300];
        }),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) => states.contains(WidgetState.disabled) ? Colors.red : null,
        ),
      )),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(fontFamily: kPrimaryFont),
      ),
      checkboxTheme: const CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.elliptical(3, 3),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kSecondaryColor,
        selectionColor: kSecondaryColor40,
        selectionHandleColor: kSecondaryColor,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 14,
          fontFamily: kSecondaryFont,
          color: Colors.white,
        ),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 8,
        activeTrackColor: ThemeManager.kPrimaryColor90,
        activeTickMarkColor: ThemeManager.kPrimaryColor,
        inactiveTrackColor: Colors.white10,
        inactiveTickMarkColor: Colors.white30,
        thumbColor: ThemeManager.kPrimaryColor,
        valueIndicatorColor: Colors.amber,
        tickMarkShape: SliderTickMarkShape.noTickMark,
        overlayColor: ThemeManager.kPrimaryColor90,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
      ),
    );
  }

  static ThemeData getRadioTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }

  static ThemeData getExpansionTileTheme(BuildContext context, {bool primaryTheme = true}) {
    return Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      unselectedWidgetColor: primaryTheme ? kPrimaryColor : kPrimaryLightColor,
      colorScheme: ColorScheme.light(
        secondary: Colors.blue,
        primary: primaryTheme ? kSecondaryColor : kPrimaryLightColor,
      ),
      dividerColor: Colors.transparent,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontFamily: kPrimaryFont,
          color: kPrimaryColor,
          fontSize: 14,
          fontWeight: primaryTheme ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  static ThemeData getThemeForDrawerMenu(BuildContext context, {bool disableHighlight = false}) {
    return Theme.of(context).copyWith(
      splashColor: Colors.grey[200],
      highlightColor: disableHighlight ? Colors.transparent : kSecondaryColor40,
      unselectedWidgetColor: Colors.red,
      dividerColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.blue,
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontFamily: kPrimaryFont,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: kPrimaryFont,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontFamily: kPrimaryFont,
        ),
      ),
    );
  }
}
