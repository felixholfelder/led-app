import 'package:flutter/material.dart';
import 'package:led_app/service/ColorService.dart';
import 'package:led_app/service/MqttService.dart';
import 'package:led_app/ui/AnimationElement.dart';
import 'package:led_app/ui/ColorElement.dart';

import '../model/AnimationModel.dart';
import '../model/ColorModel.dart';
import '../service/AnimationService.dart';
import 'DevicePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.callback});

  final Function callback;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ColorModel> colors = List.empty();
  List<AnimationModel> animations = List.empty();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("LED"),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.color_lens, size: 28),
            icon: Icon(Icons.color_lens_outlined, size: 28),
            label: "Farben",
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline, size: 28),
            selectedIcon: Icon(Icons.play_circle, size: 28),
            label: "Animationen",
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined, size: 28),
            selectedIcon: Icon(Icons.sports_esports, size: 28),
            label: "Geräte",
          ),
        ],
      ),
      body: <Widget>[
        Center(
          child: GridView.builder(
            itemCount: colors.length,
            itemBuilder: (context, index) => ColorElement(
                color: _getColor(colors, index),
                callback: _disableColorIndicators,
                confirmCallback: _disableAnimationIndicator,
                index: index),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
          ),
        ),

        //TODO - added AnimationElement and it's functionality
        Center(
          child: GridView.builder(
            itemCount: animations.length,
            itemBuilder: (context, index) => AnimationElement(
                animation: _getAnimation(animations, index), callback: _changeAnimationIndicator, index: index),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
          ),
        ),

        const Center(
          child: DevicePage(),
        ),
      ][currentPageIndex],
    );
  }

  @override
  void initState() {
    super.initState();

    MqttService.connect();
    _load();
  }

  void _load() async {
    animations = await AnimationService.getAnimations();

    setState(() => colors = ColorService.getColors());
    setState(() => animations);
  }

  void _disableColorIndicators(int selectedIndex) {
    for (int i = 0; i < colors.length; i++) {
      colors[i].isSelected = false;
      if (i == selectedIndex) {
        colors[i].isSelected = true;
        widget.callback(colors[i].color);
      }
    }
    setState(() => colors);
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

  ColorModel _getColor(List<ColorModel> colors, int index) => colors[index];

  AnimationModel _getAnimation(List<AnimationModel> animations, int index) => animations[index];
}
