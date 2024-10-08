import 'package:flutter/material.dart';
import 'package:led_app/model/ColorModel.dart';

class ColorService {
  static List<int> swatches = [0, 900, 800, 700, 600, 500, 400, 300, 200];

  static List<ColorModel> getColors() {
    List<ColorModel> list = List.empty(growable: true);

    for (int i = 0; i < Colors.primaries.length; i++) {
      for (int swatch in swatches) {
        Color? c;

        if (swatch == 0) {
          try {
            c = Colors.accents[i][700];
          } catch (_) {
            c = null;
          }
        } else {
          c = Colors.primaries[i][swatch];
        }
        if (c != null) {
          list.add(ColorModel(color: c, isSelected: false));
        }
      }
    }
    return list;
  }
}
