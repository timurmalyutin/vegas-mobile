import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.dark,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.main,
    onPrimary: AppColors.dark,
    secondary: AppColors.dark,
    onSecondary: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.dark,
    error: Colors.red,
    onError: Colors.white,
  ),
  textTheme: GoogleFonts.montserratTextTheme(),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.dark,
    foregroundColor: AppColors.white,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.main,
    onPrimary: AppColors.white,
    secondary: AppColors.white,
    onSecondary: AppColors.dark,
    surface: AppColors.dark,
    onSurface: AppColors.white,
    error: Colors.red,
    onError: Colors.black,
  ),
  textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
);
