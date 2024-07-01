import 'dart:ui';

import 'package:flutter/material.dart';

class ColorService {
  static List<int> swatches = [0, 900, 800, 700, 600, 500, 400, 300, 200, 100];

  static List<Color> getColors() {
    List<Color> list = List.empty(growable: true);

    for (int i = 0; i < Colors.primaries.length; i++) {
      for (int swatch in swatches) {
        Color? c = Colors.primaries[i][swatch];
        if (c != null) {
          list.add(c);
        }
      }
    }
    return list;
  }
}