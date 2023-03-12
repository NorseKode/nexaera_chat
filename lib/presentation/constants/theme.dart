import 'package:flutter/material.dart';

import 'colorscheme.dart';

enum AppThemeEnum {
  lightTheme,
  darkTheme,
}

class AppThemeData {
  static final appThemeData = {
    AppThemeEnum.lightTheme: ThemeData(),
    AppThemeEnum.darkTheme: ThemeData(
      splashFactory: NoSplash.splashFactory,
      primaryColor: darkColorScheme.primary,
      fontFamily: 'SpaceGrotesk',
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      textTheme: _textTheme,
      snackBarTheme: SnackBarThemeData(
          backgroundColor: darkColorScheme.primary,
          contentTextStyle: TextStyle(color: darkColorScheme.onPrimary)),
      appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.background),
    ),
  };

  static final TextTheme _textTheme = const TextTheme(
          headlineMedium: TextStyle(),
          headlineSmall: TextStyle(fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'Inter'))
      .apply(
    bodyColor: darkColorScheme.onBackground,
    displayColor: darkColorScheme.onBackground,
  );
}
