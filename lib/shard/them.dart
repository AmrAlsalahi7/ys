import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'common/myColors.dart';

ThemeData dartTheme =  ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: HexColor('080405'),
    appBarTheme: AppBarTheme(
      //backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.dark,

      ),
      backgroundColor: Colors.green,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      //Icon search color
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.white70,
      elevation: 40.0,
      backgroundColor: Colors.green,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    fontFamily: 'Jannah');

ThemeData ligthTheme = ThemeData(
    primarySwatch: MyColors.kPrimaryColor,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      //backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: MyColors.kPrimaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor:MyColors.green,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      //Icon search color
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MyColors.white,
      unselectedItemColor: Colors.black,
      elevation: 40.0,
      backgroundColor: MyColors.kPrimaryColor,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 14.0,
        overflow:TextOverflow.ellipsis,
        color: Colors.black,
      ),
    ),
    fontFamily: 'Jannah');
