import 'dart:io';
import 'package:flutter/material.dart';

// Colors
const cBackgroundColor = Color(0x131521FF);

const cPrimaryColor = Color(0x783E88FF);
const cSecondaryColor = Color(0xF86F67FF);
const cPrimaryGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cPrimaryColor, cSecondaryColor],
);

const cTextPrimaryColor = Color(0xFFFFFFFF);
const cTextSecondaryColor = Color(0xB1B2D1FF);
const cTextTertiaryColor = Color(0x7C7B9FFF);

const cButtonHighlightedPrimaryColor = Color(0x2D2F3CFF);
const cButtonHighlightedSecondaryColor = Color(0x363749FF);
const cButtonHighlightedGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cButtonHighlightedPrimaryColor, cButtonHighlightedSecondaryColor],
);

const cButtonBackgroundColor = Color(0x1F212EFF);

const cIconPrimaryColor = Color(0xFFFFFFFF);
const cIconSecondaryColor = Color(0x4DC4C4C4);
const cIconGradiant = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [cIconPrimaryColor, cIconSecondaryColor],
);

const fPoppins = 'Poppins';

//#region Titles
var fUpperTitle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextTertiaryColor,
  fontSize: 20.0,
  decoration: TextDecoration.none,
);

var fTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 25.0,
  decoration: TextDecoration.none,
);

var fTitle2Style = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 21.0,
  decoration: TextDecoration.none,
);

var fUnderTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Buttons
// e.g. placeholder text for search field
var fContentTextStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);

var fSmallTextButtonStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextSecondaryColor,
  fontSize: 12.0,
  decoration: TextDecoration.none,
);

var fElevatedButtonStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 17.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region List
var fListTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

var fListUnderTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextSecondaryColor,
  fontSize: 10.0,
  decoration: TextDecoration.none,
);

var fListLabelStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextTertiaryColor,
  fontSize: 9.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Card
var fCardTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

var fCardUnderTitleStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextPrimaryColor,
  fontSize: 10.0,
  decoration: TextDecoration.none,
);
//#endregion

//#region Miscellaneous
var fCaptionTextStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextSecondaryColor,
  fontSize: 14.0,
  decoration: TextDecoration.none,
);

// e.g. search results text
var fResultTextStyle = TextStyle(
  fontFamily: Platform.isIOS ? fPoppins : null,
  color: cTextTertiaryColor,
  fontSize: 16.0,
  decoration: TextDecoration.none,
);
//#endregion
