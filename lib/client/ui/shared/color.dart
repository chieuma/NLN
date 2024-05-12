import 'package:flutter/material.dart';

Color getColorFromString(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'yellow':
      return Colors.yellow;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'teal':
      return Colors.teal;
    case 'pink':
      return Colors.pink;
    case 'cyan':
      return Colors.cyan;
    case 'indigo':
      return Colors.indigo;
    case 'amber':
      return Colors.amber;
    case 'lime':
      return Colors.lime;
    case 'grey':
      return Colors.grey;
    case 'white':
      return Colors.white;
    case 'lightGreen':
      return Colors.lightGreen;
    case 'deepOrange':
      return Colors.deepOrange;
    case 'deepPurple':
      return Colors.deepPurple;
    case 'lightBlue':
      return Colors.lightBlue;

    default:
      return Colors.black; // Mặc định màu đen nếu không khớp
  }
}
