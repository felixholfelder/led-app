import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:led_app/model/AnimationModel.dart';

class AnimationService {
  static Future<List<AnimationModel>> getAnimations() async {
    final String response = await rootBundle.loadString("assets/animations.json");
    final List<dynamic> body = jsonDecode(response);

    List<AnimationModel> list = body.map((dynamic item) => AnimationModel.fromJson(item)).toList();

    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}
