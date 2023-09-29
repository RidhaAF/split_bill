import 'package:flutter/material.dart';

double defaultMargin = 16;
double defaultRadius = 8;

Color rustGreyColor = const Color(0xFF47585C);
Color willowGreyColor = const Color(0xFFC8D5BB);
Color primaryColor = rustGreyColor;
Color secondaryColor = willowGreyColor;
Color beigeColor = const Color(0xFFF5F5DC);
Color mutedColor = Colors.grey;
Color lightGreyColor = Colors.grey.shade300;
Color greyColor = Colors.grey.shade700;
Color darkColor = const Color(0xFF090A0A);
Color darkGreyColor = const Color(0xFF1D1D1D);
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color white70Color = Colors.white70;
Color greenColor = Colors.green;
Color darkGreenColor = Colors.green.shade900;
Color yellowColor = Colors.yellow;
Color darkYellowColor = Colors.yellow.shade800;
Color orangeColor = Colors.orange;
Color darkOrangeColor = Colors.orange.shade900;
Color redColor = Colors.red;
Color darkRedColor = Colors.red.shade900;
Color purpleColor = Colors.purple;
Color darkPurpleColor = Colors.purple.shade900;
Color brownColor = Colors.brown;
Color darkBrownColor = Colors.brown.shade900;
Color pinkColor = Colors.pink;
Color darkPinkColor = Colors.pink.shade900;
Color blueColor = Colors.blue;
Color darkBlueColor = Colors.blue.shade900;
Color bgColorDark1 = const Color(0xFF1A1A1A);
Color bgColorDark2 = blackColor;
Color bgColorDark3 = const Color(0xFF1D1D1D);
Color bgColorDark4 = const Color(0xFF111111);
Color bgColorLight1 = const Color(0xFFF5F5F5);
Color bgColorLight2 = whiteColor;
Color bgColorLight3 = const Color(0xFFE9E9E9);

LinearGradient japaneseGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColor,
    secondaryColor,
  ],
);

double largeTitleFS = 32;
double title1FS = 28;
double title2FS = 24;
double title3FS = 20;
double headlineFS = 18;
double bodyFS = 18;
double calloutFS = 16;
double subheadlineFS = 14;
double footnoteFS = 13;
double caption1FS = 12;
double caption2FS = 10;

FontWeight thin = FontWeight.w100;
FontWeight extraLight = FontWeight.w200;
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

// 32
TextStyle largeTitle = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: largeTitleFS,
);

// 28
TextStyle title1 = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: title1FS,
);

// 24
TextStyle title2 = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: title2FS,
);

// 20
TextStyle title3 = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: title3FS,
);

// 18
TextStyle headline = TextStyle(
  color: whiteColor,
  fontFamily: 'MaaxRounded',
  fontSize: headlineFS,
  fontWeight: semiBold,
);

// 18
TextStyle body = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: bodyFS,
);

// 16
TextStyle callout = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: calloutFS,
);

// 14
TextStyle subheadline = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: subheadlineFS,
);

// 13
TextStyle footnote = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: footnoteFS,
);

// 12
TextStyle caption1 = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: caption1FS,
);

// 10
TextStyle caption2 = TextStyle(
  fontFamily: 'MaaxRounded',
  fontSize: caption2FS,
);

// text style per color
TextStyle primaryTextStyle = TextStyle(
  color: primaryColor,
  fontFamily: 'MaaxRounded',
);

TextStyle secondaryTextStyle = TextStyle(
  color: secondaryColor,
  fontFamily: 'MaaxRounded',
);

TextStyle mutedTextStyle = TextStyle(
  color: mutedColor,
  fontFamily: 'MaaxRounded',
);

TextStyle whiteTextStyle = TextStyle(
  color: whiteColor,
  fontFamily: 'MaaxRounded',
);

TextStyle darkGreyTextStyle = TextStyle(
  color: darkGreyColor,
  fontFamily: 'MaaxRounded',
);

ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.zero,
  backgroundColor: primaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(defaultRadius),
  ),
);

ButtonStyle darkGreyButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.zero,
  backgroundColor: darkGreyColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(defaultRadius),
  ),
);

Border primaryBorder = Border.all(
  width: 1,
  color: primaryColor,
);

BoxShadow primaryBoxShadow = BoxShadow(
  color: blackColor.withOpacity(0.10),
  spreadRadius: 0,
  blurRadius: 16,
  offset: const Offset(0, 0), // changes position of shadow
);

RoundedRectangleBorder cardBorderRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(defaultRadius),
  ),
);

ShapeBorder radiusTopLeftRight = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(defaultRadius * 3),
    topRight: Radius.circular(defaultRadius * 3),
  ),
);
