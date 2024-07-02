import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/SharedPreferencesService.dart';
import 'package:led_app/ui/DeviceElement.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final SharedPreferencesService _prefService = SharedPreferencesService();

  List<Device> devices = [];

  @override
  Widget build(BuildContext context) {
    return devices.isNotEmpty
        ? ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) =>
                DeviceElement(device: devices[index], onclick: () => _selectDevice(devices[index])))
        : const Text("Keine Geräte vorhanden");
  }

  @override
  void initState() {
    super.initState();

    _loadDevices();
    _setSelected();
  }

  Future<void> _loadDevices() async {
    final String response = await rootBundle.loadString("assets/devices.json");
    final List<dynamic> body = jsonDecode(response);

    List<Device> list = body.map((dynamic item) => Device.fromJson(item)).toList();
    setState(() => devices = list);
  }

  Future<void> _setSelected() async {
    Device? currDevice = await _prefService.getCurrDevice();
    if (currDevice != null) {
      for (var element in devices) {
        element.isSelected = false;
        if (element.name == currDevice.name) {
          setState(() => element.isSelected = true);
        }
      }
    }
  }

  void _selectDevice(Device device) {
    _prefService.saveCurrDevice(device);
    _setSelected();
    //TODO - subscribe to mqtt broker
  }
}
