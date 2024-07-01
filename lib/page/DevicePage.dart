import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:led_app/model/Device.dart';
import 'package:led_app/ui/DeviceElement.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter/services.dart' show rootBundle;

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  bool _loading = true;
  List<Device> devices = [];

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: _loading,
        child: devices.isNotEmpty
            ? ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) => DeviceElement(device: devices[index])
              )
            : const Text("Keine Geräte vorhanden")
    );
  }

  @override
  void initState() {
    super.initState();

    _loadDevices();
    setState(() => _loading = false);
  }

  Future<void> _loadDevices() async {
    final String response = await rootBundle.loadString("assets/devices.json");
    final List<Map<String, dynamic>> body = json.decode(response);

    List<Device> list = body.map((dynamic item) => Device.fromJson(item)).toList();
    setState(() {
      devices = list;
    });
  }

}
