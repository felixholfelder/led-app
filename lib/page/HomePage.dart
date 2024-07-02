import 'package:flutter/material.dart';
import 'package:led_app/service/ColorService.dart';
import 'package:led_app/ui/AnimationElement.dart';
import 'package:led_app/ui/ColorElement.dart';

import '../model/AnimationModel.dart';
import '../service/AnimationService.dart';
import 'DevicePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = List.empty();
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
            selectedIcon: Icon(Icons.color_lens),
            icon: Icon(Icons.color_lens_outlined),
            label: "Farben",
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            selectedIcon: Icon(Icons.play_circle),
            label: "Animationen",
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            selectedIcon: Icon(Icons.play_circle),
            label: "Geräte",
          ),
        ],
      ),
      body: <Widget>[
        Center(
          child: GridView.builder(
            itemCount: colors.length,
            itemBuilder: (context, index) => ColorElement(color: _getColor(colors, index)),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ),

        //TODO - added AnimationElement and it's functionality
        Center(
          child: GridView.builder(
            itemCount: animations.length,
            itemBuilder: (context, index) => AnimationElement(animation: _getAnimaion(animations, index)),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
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

    _load();
  }

  void _load() async {
    animations = await AnimationService.getAnimations();

    setState(() => colors = ColorService.getColors());
    setState(() => animations);
  }

  Color _getColor(List<Color> colors, int index) => colors[index];
  AnimationModel _getAnimaion(List<AnimationModel> animations, int index) => animations[index];

  void _showDevicePage() => Navigator.push(context, MaterialPageRoute(builder: (context) => const DevicePage()));
}
