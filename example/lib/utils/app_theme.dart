import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();
static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const Color notWhite = Color(0xFFEDF0F2);
  static const _defaultElevation = 2.5;

  static ThemeData _baseTheme(
    Brightness brightness, {
    Color? textColor,
    Color? accentColor,
    Color? onAccentColor,
    Color? scaffoldBackgroundColor,
  }) {
    late final ColorScheme defaultColorScheme;
    late final SystemUiOverlayStyle systemUiOverlayStyle;
    switch (brightness) {
      case Brightness.light:
        defaultColorScheme = const ColorScheme.light();
        systemUiOverlayStyle = SystemUiOverlayStyle.dark;
        textColor ??= Colors.black;
        break;
      case Brightness.dark:
        defaultColorScheme = const ColorScheme.dark();
        systemUiOverlayStyle = SystemUiOverlayStyle.light;
        textColor ??= Colors.white;
        break;
    }

    return ThemeData(
      brightness: brightness,
      iconTheme: IconThemeData(color: textColor),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        elevation: _defaultElevation,
        systemOverlayStyle: systemUiOverlayStyle,
        color: scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: textColor),
        actionsIconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      colorScheme: defaultColorScheme.copyWith(
        brightness: brightness,
        // primary: accentColor,
        secondary: accentColor,
        onSecondary: onAccentColor ?? textColor,
      ),
      toggleableActiveColor: accentColor,
      // textSelectionTheme: TextSelectionThemeData(
      //   cursorColor: accentColor,
      //   selectionColor: accentColor?.withOpacity(0.75),
      //   selectionHandleColor: accentColor?.withOpacity(0.75),
      // ),
      dialogTheme: DialogTheme(
        elevation: _defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: _defaultElevation,
        highlightElevation: _defaultElevation * 2,
        // backgroundColor: accentColor,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: _defaultElevation,
        backgroundColor: accentColor,
        contentTextStyle: TextStyle(
          fontSize: 16,
          color: onAccentColor ?? textColor,
        ),
        behavior: SnackBarBehavior.floating,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
      ),
      // cupertinoOverrideTheme: CupertinoThemeData(
      //   brightness: brightness,
      //   scaffoldBackgroundColor: scaffoldBackgroundColor,
      // ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          for (final targetValue in TargetPlatform.values)
            targetValue: const _SlideLeftTransitionsBuilder(),
        },
      ),
    );
  }

  static final lightTheme = _baseTheme(
    Brightness.light,
    accentColor: const Color(0xFF0669F8),
    onAccentColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFFDCDFE2),
  ).copyWith(
    cardColor: const Color(0xFFCACFD6),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFAFAFA),
    ),
  );

  static final darkTheme = _baseTheme(
    Brightness.dark,
    accentColor: Colors.tealAccent,
    onAccentColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xFF040F2D),
  ).copyWith(
    cardColor: const Color(0xFF091642),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF050C25),
    ),
  );

}

class _SlideLeftTransitionsBuilder extends PageTransitionsBuilder {
  const _SlideLeftTransitionsBuilder();

  @override
  Widget buildTransitions<T>(_, __, animation, ___, child) {
    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ).drive(Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      )),
      child: child,
    );
  }
}
