import 'package:flutter/material.dart';
import 'package:led_app/service/MqttService.dart';

import '../model/AnimationModel.dart';
import '../model/ColorMqttMessage.dart';
import '../utils/ColorStore.dart';

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
                onTap: () => _sendAnimation(),
                title: Text(widget.animation.name),
              ),
            ),
          ),
        ),
        if (widget.animation.isSelected) Center(child: Icon(Icons.done, size: 60, color: Colors.grey.withOpacity(0.5))),
      ],
    );
  }

  void _sendAnimation() async {
    ColorStore.animationId = widget.animation.id;
    bool sent = await MqttService.send(ColorMqttMessage(color: ColorStore.color!, animationId: widget.animation.id).getTelegram());

    if (!sent) {
      _openNoSelectionDialog(context);
    } else {
      widget.callback(widget.index);
    }
  }

  Future<void> _openNoSelectionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Du hast kein Gerät ausgewählt"),
            actionsOverflowButtonSpacing: 20,
            actions: [
              //TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Abbrechen")),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
