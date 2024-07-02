import 'package:flutter/material.dart';

import '../components/board_position.dart';

Color boardColor = Colors.grey.shade700;
Color blackCowColor = Colors.black;
Color whiteCowColor = Colors.white;
Color backgroundColor = Colors.white54;
Color selectedColor = Colors.red.shade500;

const cowLocations = <int>[
  0, //[0,0],
  7, //[0,7],
  14, //[0,14],
  32, //[2,2],
  37, //[2,7],
  42, //[2,12],
  64, //[7,0],
  67, //[7,2],
  70, //[7,4],
  105,
  107,
  109,
  112,
  115,
  117,
  119,
  154,
  157,
  160,
  182,
  187,
  192,
  210,
  217,
  224
];

const midPositions = [
  BoardPosition(7, 7),
  BoardPosition(2, 7),
  BoardPosition(7, 2),
  BoardPosition(12, 7),
  BoardPosition(7, 12)
];

const vSpecialPos = [
  BoardPosition(4, 7),
  BoardPosition(10, 7),
];
const hSpecialPos = [
  BoardPosition(7, 4),
  BoardPosition(7, 10),
];

const List<List<int>> moves = [
  [-1, 0], //top
  [0, 1], //right
  [1, 0], //bottom
  [0, -1], //left
  [-1, -1], //top left
  [1, 1], //bottom right
  [-1, 1], //top right
  [1, -1], //bottom left
];

const captureMoves = [
  [0, -1], //left
  [0, 1], //right
  [-1, 0], //top
  [1, 0], //bottom
];
