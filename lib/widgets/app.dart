import 'package:estudador/widgets/home.dart';
import 'package:estudador/widgets/splashscreen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  final MaterialColor primaryColor = MaterialColor(
    0xFF345574,
    <int, Color>{
       50: Color(0xFFE7EFF3),
      100: Color(0xFFC2D8E1),
      200: Color(0xFF99BECD),
      300: Color(0xFF70A3B9),
      400: Color(0xFF5290AA),
      500: Color(0xFF337c9b),
      600: Color(0xFF2E7493),
      700: Color(0xFF276989),
      800: Color(0xFF205F7F),
      900: Color(0xFF144C6D),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenPage(),
    );
  }
}