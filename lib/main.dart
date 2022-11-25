import 'package:dragdropquiz/constant/data.dart';
import 'package:dragdropquiz/levels_grid.dart';
import 'package:dragdropquiz/page1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (context) {
        h = MediaQuery.of(context).size.height;
        w = MediaQuery.of(context).size.width;
        return LevelsGridPage();
        Page1(levels.first);
      }),
    );
  }
}
