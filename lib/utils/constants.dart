import 'package:flutter/material.dart';

const kScaffoldColor = Color(0xFF000000);
const kPrimaryColor = Color(0xFF00FF00);

ThemeData themeData = ThemeData(
  accentColor: kPrimaryColor,
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kScaffoldColor,
);
