// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';

import 'package:dragdropquiz/constant/data.dart';
import 'package:dragdropquiz/constant/imgpaths.dart';
import 'package:dragdropquiz/model/levelmodel.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  LevelModel level;
  Page1(this.level, {Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

double _boxSize = 50;
RenderBox? box;
double _gapFromTop = 50;
Map<int, int> userAnswers = {};
Map<int, Offset> startPoints = {};
Map<int, Offset> endPoints = {};
Offset _tempStartPoint = Offset.zero;
Offset _tempEndPoint = Offset.zero;

class _Page1State extends State<Page1> {
  static List<int> itemNos = [2, 6, 8];
  List<int> namesNos = [2, 6, 8];
  List<int> imgNos = [2, 6, 8];
  List<String> statsData = [
    "${userAnswers.length}/${itemNos.length}",
    "${correctsNo}/${itemNos.length} ",
    "${userAnswers.length - correctsNo}/${itemNos.length} ",
  ];
  List<Color> statsBoxColors = const [
    Colors.deepPurple,
    Colors.green,
    Colors.red
  ];
  List<Widget> icons = [
    Icon(
      Icons.question_mark,
      size: w * 0.04,
    ),
    Icon(
      Icons.check,
      size: w * 0.04,
    ),
    Icon(
      Icons.close,
      size: w * 0.04,
    )
  ];
  @override
  void initState() {
    resetData();
    itemNos = List.from(widget.level.itemNos);
    _boxSize = w / (itemNos.length);
    // TODO: implement initState
    super.initState();
    correctsNo = 0;
    _gapFromTop = h * 0.1;
    double fromTop = _boxSize * 0.5 + _gapFromTop;
    double fromBottom = h - _boxSize * 0.5;
    namesNos = List.from(itemNos);
    imgNos = List.from(itemNos);
    namesNos.shuffle();
    imgNos.shuffle();

    List.generate(namesNos.length, (i) {
      startPoints.putIfAbsent(
          namesNos[i], () => Offset(_boxSize * 0.5 + i * _boxSize, fromTop));
    });
    List.generate(imgNos.length, (i) {
      endPoints.putIfAbsent(
          imgNos[i], () => Offset(_boxSize * 0.5 + i * _boxSize, fromBottom));
    });
  }

  GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    statsData = [
      "${userAnswers.length}/${itemNos.length}",
      "${correctsNo}/${itemNos.length} ",
      "${userAnswers.length - correctsNo}/${itemNos.length} ",
    ];
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
          key: _containerKey,
          width: w,
          height: h,
          child: Stack(
            children: [
              ...startPoints.values.map((e) {
                return Positioned(
                    left: e.dx,
                    top: e.dy,
                    child: CircleAvatar(
                      radius: 4,
                    ));
              }),
              ...endPoints.values.map((e) {
                return Positioned(
                    left: e.dx,
                    top: e.dy,
                    child: CircleAvatar(
                      radius: 4,
                    ));
              }),
              IgnorePointer(
                ignoring: true,
                child: CustomPaint(
                  size: Size(w, h),
                  painter: _Painter(),
                ),
              ),
              Column(
                children: [
                  topBar(),
                  nameRow(),
                  Spacer(),
                  imageRow(),
                ],
              ),
            ],
          )),
    );
  }

  nameRow() {
    return Container(
      width: w,
      height: _boxSize,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemNos.length,
          itemBuilder: (c, i) {
            return Draggable<int>(
              data: namesNos[i],
              onDragEnd: (d) {
                log("on drag end $d");
              },
              onDraggableCanceled: (velocity, offset) {
                _tempStartPoint = Offset.zero;
                _tempEndPoint = Offset.zero;
                setState(() {});
                log("on drag onDraggableCanceled $velocity /  ${box?.localToGlobal(offset)}");
              },
              onDragUpdate: (d) {
                log("on drag onDragUpdate $d / ${d.globalPosition}");
                setState(() {
                  _tempStartPoint = startPoints[namesNos[i]] ?? Offset.zero;
                  _tempEndPoint = d.globalPosition;
                });
              },
              onDragCompleted: () {
                log("on drag onDragCompleted ");
                _tempStartPoint = Offset.zero;
                _tempEndPoint = Offset.zero;
                 correctsNo = 0;
    userAnswers.forEach((k, v) {
      if (k == v) {
        correctsNo++;
      }
    });
                setState(() {});
              },
              feedback: Material(
                color: Colors.transparent,
                child: Container(
                  width: _boxSize,
                  height: _boxSize,
                  margin: EdgeInsets.all(w * 0.04),
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[i % Colors.primaries.length].shade200
                          .withAlpha(255),
                      borderRadius: BorderRadius.circular(w * 0.08)),
                  child: Center(
                    child: Text(
                      namesMap[namesNos[i]]!,
                         textAlign: TextAlign.center,
                      style: TextStyle(fontSize: _boxSize*0.15),
                    ),
                  ),
                ),
              ),
              child: Container(
                width: _boxSize,
                height: _boxSize,
                padding: EdgeInsets.all(w * 0.02),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[i % Colors.primaries.length].shade200
                          .withAlpha(255),
                      borderRadius: BorderRadius.circular(w * 0.06)),
                  child: Center(
                    child: Text(
                      namesMap[namesNos[i]]!,
                    textAlign: TextAlign.center,
                      style: TextStyle(fontSize: _boxSize*0.15),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  imageRow() {
    return Container(
      width: w,
      height: _boxSize,
      child: ListView.builder(
          itemCount: itemNos.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) {
            return Container(
              padding: EdgeInsets.all(w * 0.02),
              width: _boxSize,
              height: _boxSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.06),
                child: DragTarget(
                  onWillAccept: (d) {
                    return true;
                  },
                  onAccept: (int d) {
                    if (!userAnswers.containsValue(imgNos[i])) {
                      userAnswers.putIfAbsent(d, () => imgNos[i]);
                      log("on accpet calle draged this $d on this ${imgNos[i]} ");
                    }
                    log("on accpet ${userAnswers.length}     NOTTTTT called this $d on this ${imgNos[i]} ");
                    setState(() {});
                  },
                  builder: (BuildContext context, List<Object?> candidateData,
                      List<dynamic> rejectedData) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors
                              .primaries[i % Colors.primaries.length].shade200
                              .withAlpha(255),
                          borderRadius: BorderRadius.circular(w * 0.06)),
                      child: Image.asset(
                        "${imgPath + namesMap[imgNos[i]]!}" + ".png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  static int correctsNo = 0;
  topBar() {
   
    return Container(
      height: _gapFromTop,
      width: w,
      color: Colors.amber.shade100.withAlpha(255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: w * 0.08,
            // color: Colors.red,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: FittedBox(
                  child: Icon(Icons.arrow_back),
                )),
          ),
          Container(
            width: w * 0.16,
            child: Text(
              "Level\n${widget.level.levelNo + 1}",
              style: TextStyle(fontSize: w * 0.05),
              textAlign: TextAlign.center,
            ),
          ),
          ...List.generate(statsData.length, (i) {
            return _statsDataWithIcon(i);
          })
        ],
      ),
    );
  }

  _statsDataWithIcon(i) {
    return Container(
      width: w * 0.2,
      decoration:
          BoxDecoration(border: Border.all(color: statsBoxColors[i], width: 3)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${statsData[i]}",
            style: TextStyle(fontSize: w * 0.05),
          ),
          icons[i]
        ],
      ),
    );
  }

  void resetData() {
    userAnswers = {};
    startPoints = {};
    endPoints = {};
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> starts = [...startPoints.values];
    List<Offset> ends = [...endPoints.values];
    log("startPoints $startPoints /\n $endPoints \n ${userAnswers}");
    for (var i = 0; i < userAnswers.length; i++) {
      Paint correctPaint = Paint()
        ..color = Colors.green
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke;
      Paint wrongPaint = Paint()
        ..color = Colors.red.withAlpha(255)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke;
      Path path = Path();
      log("startPoints userAnswer $i :  ${userAnswers.entries.toList()[i].key} / ${userAnswers.entries.toList()[i].value} ");

      path.moveTo(startPoints[userAnswers.entries.toList()[i].key]!.dx,
          startPoints[userAnswers.entries.toList()[i].key]!.dy);
      path.lineTo(endPoints[userAnswers.entries.toList()[i].value]!.dx,
          endPoints[userAnswers.entries.toList()[i].value]!.dy);
      if (userAnswers.entries.toList()[i].key ==
          userAnswers.entries.toList()[i].value) {
        canvas.drawPath(path, correctPaint);
      } else {
        canvas.drawPath(path, wrongPaint);
      }
      // canvas.drawPath(path, correctPaint);
    }
    canvas.drawLine(
        _tempStartPoint,
        _tempEndPoint,
        Paint()
          ..color = Colors.purple.withAlpha(255)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke);
    if (starts.isEmpty) {
      return;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
