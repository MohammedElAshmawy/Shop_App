import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor:HexColor('333739'),
  primarySwatch:Colors.orange,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: HexColor('333739'),
    backwardsCompatibility: false,
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.dark
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),

  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
);
ThemeData lightTheme=ThemeData(
  primarySwatch:Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: Colors.blue,
    backwardsCompatibility: false,
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

  )


  ,
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
  ),
);