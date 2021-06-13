import 'package:flutter/material.dart';

class GlobalTheme {
  //Theme Configuration for the Light Theme
  ThemeData defaultTheme = ThemeData.light().copyWith(
      primaryColor: Color(0xfff5f5f5),
      canvasColor: Color(0xfff5f5f5),
      scaffoldBackgroundColor: Color(0xffe7ecf4),
      accentColor: Color(0xFF545D68),
      textTheme: TextTheme(
          headline4: TextStyle(
              fontSize: 34,
              fontFamily: 'Varela',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD17E50)),
        headline5: TextStyle(
            fontSize: 24,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            color: Color(0xFFD17E50)),
        headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
            color: Color(0xFFD17E50)),
        bodyText1: TextStyle(
            fontSize: 16,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
            color: Colors.black),
        bodyText2: TextStyle(
            fontSize: 14,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
            color: Colors.red),
        caption: TextStyle(
            fontSize: 12,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.4,
            color: Colors.black38
        ),

        button:TextStyle(
            fontSize: 14,
            fontFamily: 'Varela',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
            color: Colors.white
        )
      ),

      appBarTheme: AppBarTheme(
          color: Color(0xfff5f5f5),
          actionsIconTheme: IconThemeData(color: Color(0xFF545D68)))
  );

}
