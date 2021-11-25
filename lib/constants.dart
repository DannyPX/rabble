import 'package:flutter/material.dart';

// Colors
const cBackgroundColor = Color(0xFF131521);

const cPrimaryColor = Color(0xFF783E88);
const cSecondaryColor = Color(0xFFF86F67);
const cPrimaryGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cPrimaryColor, cSecondaryColor],
);

const cTextPrimaryColor = Color(0xFFFFFFFF);
const cTextSecondaryColor = Color(0xFFB1B2D1);
const cTextTertiaryColor = Color(0xFF7C7B9F);

const cButtonHighlightedPrimaryColor = Color(0xFF2D2F3C);
const cButtonHighlightedSecondaryColor = Color(0xFF363749);
const cButtonHighlightedGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cButtonHighlightedPrimaryColor, cButtonHighlightedSecondaryColor],
);

const cButtonBackgroundColor = Color(0xFF1F212E);

const cIconPrimaryColor = Color(0xFFFFFFFF);
const cIconSecondaryColor = Color(0x4DC4C4C4);
const cIconGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cIconPrimaryColor, cIconSecondaryColor],
);

const cNavbarGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment(0.0, -0.3),
  colors: [Color(0x00131521), Color(0xFF131521)],
);

const fPoppins = 'Poppins';

//#region Titles
var fUpperTitle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextTertiaryColor,
  fontSize: 20.0,
  decoration: TextDecoration.none,
);

var fTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w500,
  color: cTextPrimaryColor,
  fontSize: 25.0,
  decoration: TextDecoration.none,
);

var fTitle2Style = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w500,
  color: cTextPrimaryColor,
  fontSize: 21.0,
  decoration: TextDecoration.none,
);

var fUnderTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Buttons
// e.g. placeholder text for search field
var fContentTextStyle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);

// e.g. View more buttons
var fSmallTextButtonStyle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextSecondaryColor,
  fontSize: 12.0,
  decoration: TextDecoration.none,
);

var fElevatedButtonStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w600,
  color: cTextPrimaryColor,
  fontSize: 17.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region List
var fListTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextPrimaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

var fListUnderTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w300,
  color: cTextSecondaryColor,
  fontSize: 10.0,
  decoration: TextDecoration.none,
);

var fListLabelStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w300,
  color: cTextTertiaryColor,
  fontSize: 9.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Card
var fCardTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w600,
  color: cTextPrimaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

var fCardUnderTitleStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w600,
  color: cTextPrimaryColor,
  fontSize: 10.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Miscellaneous
var fCaptionTextStyle = const TextStyle(
  fontFamily: fPoppins,
  fontWeight: FontWeight.w300,
  color: cTextSecondaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

// e.g. search results text
var fResultTextStyle = const TextStyle(
  fontFamily: fPoppins,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);
//#endregion
