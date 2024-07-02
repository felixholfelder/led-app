import 'package:flutter/material.dart';

import '../model/ColorModel.dart';

class ColorElement extends StatefulWidget {
  const ColorElement({super.key, required this.color, required this.callback, required this.index});

  final ColorModel color;
  final Function callback;
  final int index;

  @override
  State<ColorElement> createState() => _ColorElementState();
}

class _ColorElementState extends State<ColorElement> {
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
          Center(child: IconButton(icon: const Icon(Icons.done, size: 60, color: Colors.grey), onPressed: () => _changeColor())),
      ],
    );
  }

  void _changeColor() {
    //TODO - send mqtt message

    widget.callback(widget.index);
  }

  void _sendColor() {
    //TODO - send mqtt message

    widget.callback(widget.index);
  }
}
