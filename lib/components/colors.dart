import 'dart:ui';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// list of colors that we use in our app

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 17),
  blurRadius: 17,
  spreadRadius: -23,
  color: Color(0xFF035AA6), // Black color with 12% opacity
);
const kShadow = BoxShadow(
  offset: Offset(0, 17),
  blurRadius: 17,
  spreadRadius: -30,
  color: Color(0xFF035AA6), // Black color with 12% opacity
);

//colors
const kBackgroundColor = Color.fromARGB(255, 250, 248, 250);
const kPrimaryColor = Color.fromRGBO(6, 121, 249, 1);

const kTextColor = Color(0xFF000839);
const kBlueColor = Color(0xFF40BAD5);
const kImageColor = Color.fromRGBO(169, 203, 56, 1);
const kwhite = Colors.white;
const kerror = Colors.red;
const kwhite_new = Color.fromARGB(255, 19, 11, 138);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(30),
  topRight: Radius.circular(30),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(30),
  bottomLeft: Radius.circular(30),
);

final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor, fontSize: 11.sp, fontWeight: FontWeight.w500);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

var whiteNotFullColor = const Color.fromARGB(255, 196, 193, 193);
var whiteNotFullColor50 = const Color.fromARGB(255, 237, 236, 236);
var whiteColor = const Color.fromARGB(255, 255, 255, 255);
var blackColor = const Color.fromARGB(255, 39, 38, 38);
var greyColor = const Color.fromARGB(255, 57, 56, 56);
var greyColorNolot = const Color.fromARGB(255, 70, 68, 68);

var blueColor = const Color.fromARGB(255, 34, 195, 231);
var yellowColor = const Color.fromARGB(255, 221, 197, 47);
var backgroundScreen = const Color.fromARGB(255, 225, 232, 232);
var redColors = const Color.fromARGB(255, 108, 14, 14);
var greenColors = const Color.fromARGB(255, 20, 124, 6);
var greyColorNolots = Color.fromARGB(255, 148, 147, 147);
var colorsRed = const Color.fromARGB(255, 242, 37, 22);

//Contant
