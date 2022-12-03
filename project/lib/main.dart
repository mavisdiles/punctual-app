import 'package:flutter/material.dart';
import 'package:project/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF4C6EF5, {
          50: Color(0xFFEDF2FF),
          100: Color(0xFFDBE4FF),
          200: Color(0xFFBAC8FF),
          300: Color(0xFF91A7FF),
          400: Color(0xFF748FFC),
          500: Color(0xFF5C7CFA),
          600: Color(0xFF4C6EF5),
          700: Color(0xFF4263EB),
          800: Color(0xFF3B5BDB),
          900: Color(0xFF364FC7),
          })
      ),
      initialRoute:'/login',
      routes: routes,
    );
  }
}