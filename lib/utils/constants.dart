import 'package:flutter/material.dart';

const kScaffoldColor = Color(0xFF131313);
const kPrimaryColor = Colors.blue;
const kPadding = 16.0;

ThemeData themeData = ThemeData(
  accentColor: kPrimaryColor,
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kScaffoldColor,
);
