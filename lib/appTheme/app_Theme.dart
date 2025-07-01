import 'package:flutter/material.dart';

import '../extra/colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {}),
    textTheme: const TextTheme(bodyLarge: TextStyle()),

    // Define the default brightness and colors.
    brightness: Brightness.light,
    //AppBar Color
    primarySwatch: MyColor.primaryBlack,
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.black,
    // Define the default font family.
    // fontFamily: 'Georgia',
  );

  static ThemeData get darkTheme => ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      // TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      // TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
    }),
    textTheme: const TextTheme(bodyLarge: TextStyle()),
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    secondaryHeaderColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromARGB(255, 206, 149, 149),
    // backgroundColor: const Color.fromARGB(255, 206, 149, 149),
    dividerColor: Colors.black12,
  );
}