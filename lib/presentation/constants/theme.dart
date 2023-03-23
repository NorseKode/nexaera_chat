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
      cardColor: darkColorScheme.surface,
      canvasColor: darkColorScheme.surface,
      appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.background),
    ),
  };

  static final TextTheme _textTheme = const TextTheme(
          headlineMedium: TextStyle(),
          headlineSmall: TextStyle(fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'Inter'),
          bodyMedium: TextStyle(fontSize: 14, height: 1.5, fontFamily: 'Inter'),
          bodySmall: TextStyle(fontSize: 12, height: 1.5, fontFamily: 'Inter'),
          labelSmall: TextStyle(fontSize: 12))
      .apply(
    bodyColor: darkColorScheme.onBackground,
    displayColor: darkColorScheme.onBackground,
  );
}
