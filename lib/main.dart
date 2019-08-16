import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    );
  }
}
