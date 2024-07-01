import 'package:flutter/material.dart';
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/SharedPreferencesService.dart';

class DeviceElement extends StatefulWidget {
  const DeviceElement({super.key, required this.device});

  final Device device;

  @override
  State<DeviceElement> createState() => _DeviceElementState();
}

class _DeviceElementState extends State<DeviceElement> {
  final SharedPreferencesService _prefService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        child: ListTile(
          onTap: () => _selectDevice,
          title: Row(
            children: [
              const Icon(Icons.lightbulb, size: 16),
              Column(
                children: [
                  Text(widget.device.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDevice() {
    _prefService.saveCurrDevice(widget.device);
  }
}
