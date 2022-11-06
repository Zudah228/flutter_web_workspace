// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'colors.dart';

ThemeData get appTheme {
  final base = ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    focusColor: kPrimaryColor,
  );
  return base.copyWith(
    // base
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPrimaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
    iconTheme: base.iconTheme.copyWith(
      color: base.primaryColor,
    ),

    // cupertino override
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      brightness: Brightness.light,
    ),

    // scaffold
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      // iconTheme: base.iconTheme.copyWith(color: Colors.grey[300]),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.black.withOpacity(0.4),
    ),

    // buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 64,
          vertical: 24,
        ),
      ),
    ),

    // others
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: base.primaryColor,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: base.primaryColor),
    checkboxTheme: base.checkboxTheme.copyWith(
      fillColor: MaterialStateProperty.all(
        base.primaryColor,
      ),
    ),
    toggleableActiveColor: kPrimaryColor,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: kPrimaryColor),
  );
}

ThemeData get appThemeDark {
  final base = appTheme.copyWith(colorScheme: const ColorScheme.dark());
  return base.copyWith(
    // base
    primaryColor: kPrimaryColor,
    colorScheme: base.colorScheme.copyWith(secondary: kPrimaryColor),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPrimaryColor,
      textTheme: ButtonTextTheme.normal,
    ),

    // cupertino override
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
    ),

    // scaffold
    scaffoldBackgroundColor: base.colorScheme.background,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: Colors.black,
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),

    // buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: kPrimaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: kPrimaryColor,
      ),
    ),

    // others
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: base.primaryColor,
        ),
      ),
    ),
  );
}
