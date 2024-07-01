import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:led_app/ui/ColorElement.dart';
import 'DevicePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("LED"),
      ),
      body: Center(
        child: GridView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) => ColorElement(color: _getColor(colors, index)),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDevicePage,
        tooltip: 'Geräte verwalten',
        child: const Icon(Icons.light),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadColors();
  }

  void _loadColors() async {
    final String response = await rootBundle.loadString("assets/colors.json");
    final List<dynamic> body = jsonDecode(response);

    List<Color> list = body.map((dynamic item) => Color(int.parse(item))).toList();
    setState(() => colors = list);
  }

  Color _getColor(List<Color> colors, int index) => colors[index];

  void _showDevicePage() => Navigator.push(context, MaterialPageRoute(builder: (context) => const DevicePage()));
}
