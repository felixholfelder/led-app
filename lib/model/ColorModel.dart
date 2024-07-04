import 'package:flutter/material.dart';

class ColorModel {
  final Color color;
  bool isSelected;

  ColorModel({required this.color, required this.isSelected});

  @override String toString() => "[${color.red}, ${color.green}, ${color.blue}]";
}
