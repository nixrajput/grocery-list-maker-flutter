import 'package:flutter/material.dart';
import 'package:grocery_list_maker/constants/colors.dart';

class AppThemes {
  AppThemes._();

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBGColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: lightBGColor,
      modalBackgroundColor: lightBGColor,
    ),
    dialogBackgroundColor: lightBGColor,
    popupMenuTheme: const PopupMenuThemeData(
      color: lightBGColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(darkColor),
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: darkColor),
      bodyText2: TextStyle(color: darkColor),
      subtitle1: TextStyle(color: darkColor),
      subtitle2: TextStyle(color: darkColor),
      caption: TextStyle(color: darkColor),
      headline1: TextStyle(color: darkColor),
      headline2: TextStyle(color: darkColor),
      headline3: TextStyle(color: darkColor),
      headline4: TextStyle(color: darkColor),
      headline5: TextStyle(color: darkColor),
      headline6: TextStyle(color: darkColor),
      button: TextStyle(color: darkColor),
      overline: TextStyle(color: darkColor),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBGColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkColor2,
      modalBackgroundColor: darkColor2,
    ),
    dialogBackgroundColor: darkColor2,
    popupMenuTheme: const PopupMenuThemeData(
      color: darkColor2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(lightColor),
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: lightColor),
      bodyText2: TextStyle(color: lightColor),
      subtitle1: TextStyle(color: lightColor),
      subtitle2: TextStyle(color: lightColor),
      caption: TextStyle(color: lightColor),
      headline1: TextStyle(color: lightColor),
      headline2: TextStyle(color: lightColor),
      headline3: TextStyle(color: lightColor),
      headline4: TextStyle(color: lightColor),
      headline5: TextStyle(color: lightColor),
      headline6: TextStyle(color: lightColor),
      button: TextStyle(color: lightColor),
      overline: TextStyle(color: lightColor),
    ),
  );
}
