import 'package:flutter/material.dart';

class ColorElement extends StatefulWidget {
  const ColorElement({super.key, required this.color});

  final Color color;

  @override
  State<ColorElement> createState() => _ColorElementState();
}

class _ColorElementState extends State<ColorElement> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      color: widget.color,
      child: ClipPath(
        child: ListTile(
          onTap: () => {},
        ),
      ),
    );
  }

  void _sendColor() {
    //TODO - send mqtt message
  }
}
