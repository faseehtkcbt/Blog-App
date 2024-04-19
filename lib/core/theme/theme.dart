import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static _border({Color color = AppPallete.borderColor}) => OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: color,
        width: 3,
      ));

  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      chipTheme: ChipThemeData(
          backgroundColor: AppPallete.backgroundColor, side: BorderSide.none),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border(),
          focusedBorder: _border(color: AppPallete.gradient2),
          contentPadding: const EdgeInsets.all(10)));
}
