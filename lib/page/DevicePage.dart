import 'package:flutter/material.dart';
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/DeviceService.dart';
import 'package:led_app/ui/DeviceElement.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final DeviceService _deviceService = DeviceService();

  List<Device> devices = [];

  @override
  Widget build(BuildContext context) {
    //TODO - wrap in Scaffold
    //TODO - create floating action button
    //TODO - create dialog to create new device
    //TODO - create dialog to delete device on long click
    return devices.isNotEmpty
        ? ListView.builder(
            itemCount: devices.length, itemBuilder: (context, index) => DeviceElement(device: devices[index]))
        : const Text("Keine Geräte vorhanden");
  }

  @override
  void initState() {
    super.initState();

    _loadDevices();
  }

  Future<void> _loadDevices() async {
    devices = await _deviceService.getDevices();
    setState(() => devices);
  }
}
