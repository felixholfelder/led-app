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
    return Container(
      padding: const EdgeInsets.all(8),
      color: widget.color,
    );
  }
}
