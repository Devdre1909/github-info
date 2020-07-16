import 'package:flutter/material.dart';

const kScaffoldColor = Colors.black54;
const kPrimaryColor = Colors.blue;
const kPadding = 16.0;

ThemeData themeData = ThemeData(
  accentColor: kPrimaryColor,
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kScaffoldColor,
);
