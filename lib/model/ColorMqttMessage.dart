class ColorMqttMessage {
  final String? color;
  final int? animationId;
  final bool? isStaticColor;

  ColorMqttMessage({this.color, this.animationId, this.isStaticColor});

  @override String toString() => "{'color': $color, 'animationId': $animationId, 'isStaticColor': $isStaticColor}";
}
