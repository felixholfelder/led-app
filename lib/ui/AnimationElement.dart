import 'package:flutter/material.dart';
import 'package:led_app/service/MqttService.dart';

import '../model/AnimationModel.dart';

class AnimationElement extends StatefulWidget {
  const AnimationElement({super.key, required this.animation, required this.callback, required this.index});

  final AnimationModel animation;
  final Function callback;
  final int index;

  @override
  State<AnimationElement> createState() => _AnimationElementState();
}

class _AnimationElementState extends State<AnimationElement> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            color: Colors.grey[100],
            child: ClipPath(
              child: ListTile(
                onTap: () => _sendColor(),
                title: Text(widget.animation.name),
              ),
            ),
          ),
        ),
        if (widget.animation.isSelected) Center(child: Icon(Icons.done, size: 60, color: Colors.grey.withOpacity(0.5))),
      ],
    );
  }

  void _sendColor() {
    MqttService.send("New animation");

    widget.callback(widget.index);
  }
}
