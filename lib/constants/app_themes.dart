import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    dialogBackgroundColor: lightColor,
    popupMenuTheme: const PopupMenuThemeData(
      color: lightColor,
    ),
    dividerColor: Colors.grey.shade300,
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
    appBarTheme: const AppBarTheme(
      backgroundColor: lightColor,
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
        textStyle: const TextStyle(color: darkColor),
      ),
      bodyText2: GoogleFonts.poppins(
        textStyle: const TextStyle(color: darkColor),
      ),
      subtitle1: GoogleFonts.poppins(
        textStyle: TextStyle(color: darkColor.withOpacity(0.4)),
      ),
      subtitle2: GoogleFonts.poppins(
        textStyle: TextStyle(color: darkColor.withOpacity(0.4)),
      ),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBGColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkColor2,
      modalBackgroundColor: darkColor2,
    ),
    dialogBackgroundColor: darkColor,
    popupMenuTheme: const PopupMenuThemeData(
      color: darkColor2,
    ),
    dividerColor: Colors.grey.shade700,
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
    appBarTheme: const AppBarTheme(
      backgroundColor: darkColor,
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.poppins(
        textStyle: const TextStyle(color: lightColor),
      ),
      bodyText2: GoogleFonts.poppins(
        textStyle: const TextStyle(color: lightColor),
      ),
      subtitle1: GoogleFonts.poppins(
        textStyle: TextStyle(color: lightColor.withOpacity(0.4)),
      ),
      subtitle2: GoogleFonts.poppins(
        textStyle: TextStyle(color: lightColor.withOpacity(0.4)),
      ),
    ),
  );
}
