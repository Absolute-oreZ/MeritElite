/*------------------------------------------------------------------------------------------------------
  Author        : Yong
  Program       : MeritElite
  Purpose       : To 
  Date Created  : 04/01/2024
  Date Modified : None
  Version       : 1.0
------------------------------------------------------------------------------------------------------*/
import 'package:flutter/material.dart';
import 'package:merit_elite/pages/homepage.dart';

void main() => runApp(MeritElite());

class MeritElite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeritElite',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        splashColor: const Color.fromARGB(233, 196, 106, 1),
        fontFamily: "Segoe UI",
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color.fromRGBO(230, 237, 243, 1)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(1, 4, 9, 1),
          titleTextStyle: TextStyle(
            fontFamily: 'montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
