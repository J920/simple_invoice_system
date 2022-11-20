import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// all custom application theme
class AppTheme {
  /// default application theme
  static ThemeData get basic => ThemeData(
        // fontFamily: 'RB',
        primaryColor: kPrimaryColor,
        primarySwatch: kPrimarySwatch,
        canvasColor: kCanvasColor,
        appBarTheme: kAppBarTheme,
        iconTheme: kIconTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.transparent))),
            backgroundColor: MaterialStateProperty.all<Color>(
              kPrimaryColor,
            ),
            //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ), //text (and icon)
          ),
        ),
      );
}
