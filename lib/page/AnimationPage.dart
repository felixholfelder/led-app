import 'package:flutter/material.dart';
import 'package:led_app/service/ColorService.dart';
import 'package:led_app/ui/AnimationElement.dart';

import '../model/AnimationModel.dart';
import '../model/ColorModel.dart';
import '../service/AnimationService.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  List<ColorModel> colors = List.empty();
  List<AnimationModel> animations = List.empty();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: animations.length,
        itemBuilder: (context, index) => AnimationElement(
            animation: _getAnimation(animations, index), callback: _changeAnimationIndicator, index: index),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _load();
  }

  void _load() async {
    animations = await AnimationService.getAnimations();

    setState(() => colors = ColorService.getColors());
    setState(() => animations);
  }

  void _disableAnimationIndicator() {
    for (AnimationModel a in animations) {
      a.isSelected = false;
    }

    setState(() => animations);
  }

  void _changeAnimationIndicator(int selectedIndex) {
    _disableAnimationIndicator();

    for (int i = 0; i < animations.length; i++) {
      if (i == selectedIndex) {
        animations[i].isSelected = true;
      }
    }
    setState(() => animations);
  }

  AnimationModel _getAnimation(List<AnimationModel> animations, int index) => animations[index];
}
