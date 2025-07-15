import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_utils.dart';

ThemeData primaryTheme = ThemeData(
  shadowColor: ColorUtils.lightIconBackgroundColor,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
  }),
  hintColor: ColorUtils.hintColor,
  dialogBackgroundColor: ColorUtils.dialogBackgroundColor,
  popupMenuTheme: PopupMenuThemeData(
    color: ColorUtils.cardColor,
    textStyle: TextStyle(
      color: ColorUtils.hintColor,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      fontFamily: GoogleFonts.inter().fontFamily,
      color: ColorUtils.lightPrimaryHeaderTextColor,
      letterSpacing: -0.3,
    ),
    headlineLarge: TextStyle(
      color: ColorUtils.lightPrimaryHeaderTextColor,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    headlineMedium: TextStyle(
      color: ColorUtils.lightPrimaryHeaderTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ColorUtils.lightPrimaryHeaderTextColor,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    bodyMedium: TextStyle(
      color: ColorUtils.lightPrimaryBodyTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    bodySmall: TextStyle(
      color: ColorUtils.lightPrimaryBodyTextColor,
      fontSize: 14,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: ColorUtils.lightTextFieldLabelColor,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
    displaySmall: TextStyle(
      color: ColorUtils.infoTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.inter().fontFamily,
    ),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent),
  ),
  dividerColor: ColorUtils.dividerColor,
  hoverColor: ColorUtils.lightHoverColor,
  fontFamily: GoogleFonts.inter().fontFamily,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  textSelectionTheme:
      TextSelectionThemeData(cursorColor: ColorUtils.primaryColor),
  primaryColor: ColorUtils.primaryColor,
  scaffoldBackgroundColor: ColorUtils.scaffoldBackgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
      onPrimary: ColorUtils.lightSecondaryBodyTextColor,
      primaryContainer: ColorUtils.cardColor,
      secondary: ColorUtils.lightPrimaryBodyTextColor,
      outline: ColorUtils.textFieldBorderColor,
      secondaryContainer: ColorUtils.secondaryContainerColor),
  cardColor: ColorUtils.cardColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(
        ColorUtils.primaryColor,
      ),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.transparent),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 16,
          color: ColorUtils.lightPrimaryHeaderTextColor.withOpacity(0.8),
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    ),
  ),
  // shadowColor: ColorUtils.lightIconBackgroundColor,
);
