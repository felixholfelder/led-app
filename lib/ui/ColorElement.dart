import 'package:flutter/material.dart';
import 'package:led_app/model/ColorMqttMessage.dart';
import 'package:led_app/service/DeviceService.dart';
import 'package:led_app/ui/DeviceElement.dart';
import 'package:mqtt_client/mqtt_client.dart';

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

  void _changeColor() async {
    if (widget.color.isSelected) {
      _setStaticColor();
      return;
    }

    bool sent = await MqttService.send(ColorMqttMessage(color: widget.color.toString(), isStaticColor: false).toString());

    if (!sent) {
      DeviceService.showNoSelectionDialog(context);
    } else {
      widget.callback(widget.index);
    }
  }

  void _setStaticColor() async {
    bool sent = await MqttService.send(ColorMqttMessage(color: widget.color.toString(), isStaticColor: true).toString());

    if (!sent) {
      DeviceService.showNoSelectionDialog(context);
    } else {
      widget.confirmCallback();
    }
  }
}
