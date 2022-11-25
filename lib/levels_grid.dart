import 'package:dragdropquiz/constant/data.dart';
import 'package:dragdropquiz/page1.dart';
import 'package:flutter/material.dart';

class LevelsGridPage extends StatefulWidget {
  LevelsGridPage({Key? key}) : super(key: key);

  @override
  State<LevelsGridPage> createState() => _LevelsGridPageState();
}

class _LevelsGridPageState extends State<LevelsGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        child: GridView.builder(
            itemCount: levels.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (c, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page1(levels[i]),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.primaries.reversed
                        .toList()[(i + 2) % Colors.primaries.length],
                  ),
                  margin: EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    (i + 1).toString(),
                    style: TextStyle(
                        fontSize: w * 0.09, fontWeight: FontWeight.bold),
                  )),
                ),
              );
            }),
      ),
    );
  }
}
