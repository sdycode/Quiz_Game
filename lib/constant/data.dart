import 'dart:developer';

import 'package:dragdropquiz/model/levelmodel.dart';

// void main(List<String> args) {
//   for (var i = 0; i < names.length; i++) {
//     namesMap.putIfAbsent(i, () {
//       return '"${names[i]}"';
//     });
//   }
//   print(namesMap);
//   log(namesMap.toString());
// }

List<LevelModel> levels = [
  LevelModel(0, [4, 6, 8]),
  LevelModel(1, [2,10,12,5]),
  LevelModel(2, [1,5,9]),
  LevelModel(3, [3,14,13,0]),
  LevelModel(4, [11,15,16,17]),
];
double h = 200;
double w = 200;
List<String> names = [
  "apples",
  "banana",
  "bear",
  "bird",
  "box",
  "carrot",
  "dog",
  "fruit",
  "hand",
  "key",
  "lettuce",
  "onion",
  "orange",
  "pen",
  "phone",
  "pineapple",
  "pomegranate",
  "strawberries",
  "train",
];
Map<int, String> namesMap = {
  0: "apples",
  1: "banana",
  2: "bear",
  3: "bird",
  4: "box",
  5: "carrot",
  6: "dog",
  7: "fruit",
  8: "hand",
  9: "key",
  10: "lettuce",
  11: "onion",
  12: "orange",
  13: "pen",
  14: "phone",
  15: "pineapple",
  16: "pomegranate",
  17: "strawberries",
  18: "train"
};
