import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:led_app/model/AnimationModel.dart';
import 'package:path_provider/path_provider.dart';

class AnimationService {
  static Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final file = File("${localDirectory.path}/animations.json");

    if (!await file.exists() || file.readAsStringSync() == "[]") {
      final initialContent = await rootBundle.loadString("assets/animations.json");
      await file.create();
      await file.writeAsString(initialContent);
    }

    return file;
  }

  static Future<List<AnimationModel>> getAnimations() async {
    File file = await _initializeFile();
    final String response = file.readAsStringSync();
    final List<dynamic> body = jsonDecode(response);

    List<AnimationModel> list = body.map((dynamic item) => AnimationModel.fromJson(item)).toList();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}
