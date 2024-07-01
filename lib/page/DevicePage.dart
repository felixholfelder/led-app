import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/SharedPreferencesService.dart';
import 'package:led_app/ui/DeviceElement.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final SharedPreferencesService _prefService = SharedPreferencesService();

  bool _loading = true;
  List<Device> devices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Geräte"),
      ),
      body: Center(
        child: Skeletonizer(
          enabled: _loading,
          child: devices.isNotEmpty
              ? ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) =>
                      DeviceElement(device: devices[index], onclick: () => _selectDevice(devices[index])))
              : const Text("Keine Geräte vorhanden"),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadDevices();
    setState(() => _loading = false);
    _setSelected();
  }

  Future<void> _loadDevices() async {
    final String response = await rootBundle.loadString("assets/devices.json");
    final List<dynamic> body = json.decode(response);

    List<Device> list = body.map((dynamic item) => Device.fromJson(item)).toList();
    setState(() {
      devices = list;
    });
  }

  Future<void> _setSelected() async {
    Device? currDevice = await _prefService.getCurrDevice();
    if (currDevice != null) {
      devices.forEach((element) {
        if (element.name == currDevice.name) {
          element.isSelected = true;
        }
      });
    }
  }

  void _selectDevice(Device device) {
    _prefService.saveCurrDevice(device);
    //TODO - subscribe to mqtt broker
    Navigator.of(context).pop();
  }
}
