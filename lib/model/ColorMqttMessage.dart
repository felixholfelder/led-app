import 'package:led_app/MqttMessage.dart';
import 'package:led_app/model/ColorModel.dart';

import '../enums/AnimationEnum.dart';

class ColorMqttMessage extends MqttMessage {
  final ColorModel color;
  final int animationId;

  ColorMqttMessage({required this.color, required this.animationId});

  @override
  String getTelegram() => "@${color.color.red},${color.color.green},${color.color.blue},$animationId;";
}
