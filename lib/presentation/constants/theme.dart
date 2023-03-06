import 'package:flutter/material.dart';

import 'colorscheme.dart';

enum AppThemeEnum {
  lightTheme,
  darkTheme,
}

class AppThemeData {
  static final appThemeData = {
    AppThemeEnum.lightTheme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        primaryColor: lightColorScheme.primary,
        fontFamily: 'Inter',
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.background,
        textTheme: const TextTheme(
                headlineMedium: TextStyle(),
                headlineSmall: TextStyle(),
                bodyMedium: TextStyle())
            .apply(
                bodyColor: lightColorScheme.onBackground,
                displayColor: lightColorScheme.onBackground),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: lightColorScheme.primary,
            contentTextStyle: TextStyle(color: lightColorScheme.onPrimary)),
        appBarTheme: AppBarTheme(backgroundColor: lightColorScheme.background)),
    AppThemeEnum.darkTheme: ThemeData(
      splashFactory: NoSplash.splashFactory,
      primaryColor: darkColorScheme.primary,
      fontFamily: 'Inter',
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      textTheme: const TextTheme(
              headlineMedium: TextStyle(),
              headlineSmall: TextStyle(),
              bodyMedium: TextStyle())
          .apply(
              bodyColor: darkColorScheme.onBackground,
              displayColor: darkColorScheme.onBackground),
      snackBarTheme: SnackBarThemeData(
          backgroundColor: darkColorScheme.primary,
          contentTextStyle: TextStyle(color: darkColorScheme.onPrimary)),
      appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.background),
    ),
  };
}
