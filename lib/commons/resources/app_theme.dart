import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamrokhata/commons/resources/colors.dart';

class AppThemes {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        primaryColor: colorScheme.onSurface,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          foregroundColor: primaryColor,
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
          foregroundColor: Colors.white,
          focusColor: Colors.white,
        )),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        primaryIconTheme: IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          colorScheme: colorScheme,
        ),
        textTheme: textTheme,
        fontFamily: 'Roboto',
        dividerColor: dividerColor,
        disabledColor: disabledColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: colorScheme.primary,
        ));
  }

  static const textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w400,
      color: primaryColorDark,
    ),
    headline4: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: primaryColorDark,
    ),
    headline6: TextStyle(
      fontSize: 18,
    ),
    bodyText1:
        TextStyle(fontSize: 15, height: 1.5, fontWeight: FontWeight.normal),
    bodyText2: TextStyle(
      fontSize: 14,
    ),
    caption: TextStyle(
      fontSize: 12,
    ),
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    background: scaffoldBackgroundColor,
    surface: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: primaryColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundDark,
    surface: Color(0xff1E2746),
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
