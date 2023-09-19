import 'package:flutter/material.dart';
import 'package:trialtechtransform_app/constants/colors.dart';

class AppTheme {
  ThemeData appTheme() {
    return ThemeData(
        textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
            ),
            bodyMedium: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(
                fontSize: 30,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold)));
  }
}
