import 'package:flutter/material.dart';

import '../model/ColorModel.dart';
import '../service/MqttService.dart';

class ColorElement extends StatefulWidget {
  const ColorElement(
      {super.key, required this.color, required this.callback, required this.confirmCallback, required this.index});

  final ColorModel color;
  final Function callback;
  final Function confirmCallback;
  final int index;

  @override
  State<ColorElement> createState() => _ColorElementState();
}

class _ColorElementState extends State<ColorElement> {
  final MqttService _mqttService = MqttService();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Card(
            color: widget.color.color,
            child: ClipPath(
              child: ListTile(
                onTap: () => _changeColor(),
              ),
            ),
          ),
        ),
        if (widget.color.isSelected)
          Center(
              child: IconButton(
                  icon: Icon(Icons.done, color: Colors.grey[100]!.withOpacity(0.7)),
                  iconSize: 60,
                  onPressed: () => _changeColor())),
      ],
    );
  }

  void _changeColor() {
    if (widget.color.isSelected) {
      _setStaticColor();
      return;
    }

    MqttService.send("new color");

    widget.callback(widget.index);
  }

  void _setStaticColor() {
    MqttService.send("Static color");

    widget.confirmCallback();
  }
}
