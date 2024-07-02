import 'package:flutter/material.dart';

import '../model/AnimationModel.dart';

class AnimationElement extends StatefulWidget {
  const AnimationElement({super.key, required this.animation});

  final AnimationModel animation;

  @override
  State<AnimationElement> createState() => _AnimationElementState();
}

class _AnimationElementState extends State<AnimationElement> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: ClipPath(
        child: ListTile(
          onTap: () => {},
          title: Text(widget.animation.name),
        ),
      ),
    );
  }

  void _sendColor() {
    //TODO - send mqtt message
  }
}
