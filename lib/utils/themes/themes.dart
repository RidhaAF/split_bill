import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_bill/utils/constants/constants.dart';

class AppTheme {
  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: secondaryColor,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: secondaryColor,
      background: secondaryColor,
      error: redColor,
      onPrimary: secondaryColor,
      onSecondary: primaryColor,
      onSurface: primaryColor,
      onBackground: primaryColor,
      onError: whiteColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 0.0,
      selectedItemColor: secondaryColor,
      unselectedItemColor: mutedColor,
      selectedLabelStyle: footnote,
      unselectedLabelStyle: footnote,
      type: BottomNavigationBarType.fixed,
      enableFeedback: true,
    ),
    fontFamily: 'MaaxRounded',
    textTheme: TextTheme(
      titleSmall: TextStyle(
        color: greyColor,
        fontFamily: 'MaaxRounded',
      ),
      labelMedium: TextStyle(
        color: greyColor,
        fontFamily: 'MaaxRounded',
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: secondaryColor,
        fontFamily: 'MaaxRounded',
        fontSize: bodyFS,
        fontWeight: semiBold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
      enableFeedback: true,
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(
        primaryColor.withOpacity(0.1),
      ),
      shape: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.focused)) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(defaultRadius),
            ),
            side: BorderSide(color: primaryColor),
          );
        }
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultRadius),
          ),
          side: BorderSide.none,
        );
      }),
      hintStyle: MaterialStateProperty.all(
        TextStyle(
          color: greyColor,
          fontFamily: 'MaaxRounded',
          fontSize: calloutFS,
        ),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontFamily: 'MaaxRounded',
          fontSize: calloutFS,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontFamily: 'MaaxRounded',
            fontWeight: semiBold,
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(secondaryColor),
        overlayColor: MaterialStateProperty.all(
          secondaryColor.withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontFamily: 'MaaxRounded',
            fontWeight: semiBold,
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.all(primaryColor),
        overlayColor: MaterialStateProperty.all(
          primaryColor.withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: bgColorLight2,
      shape: radiusTopLeftRight,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      textTheme: CupertinoTextThemeData(
        primaryColor: primaryColor,
        dateTimePickerTextStyle: const TextStyle(
          fontFamily: 'MaaxRounded',
        ),
      ),
    ),
  );
}
