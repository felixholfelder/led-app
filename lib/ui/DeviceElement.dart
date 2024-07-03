import 'package:flutter/material.dart';
import 'package:led_app/model/Device.dart';
import 'package:led_app/service/DeviceService.dart';

class DeviceElement extends StatefulWidget {
  const DeviceElement({super.key, required this.device});

  final Device device;

  @override
  State<DeviceElement> createState() => _DeviceElementState();
}

class _DeviceElementState extends State<DeviceElement> {
  final DeviceService _deviceService = DeviceService();

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
        child: ListTile(
          onTap: () => _toggleSelection(),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: widget.device.isSelected
                    ? const Icon(Icons.lightbulb, size: 28)
                    : const Icon(Icons.lightbulb_outline, size: 28),
              ),
              Column(
                children: [
                  Text(widget.device.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSelection() {
    if (widget.device.isSelected) {
      _deviceService.removeDevice(widget.device);
      setState(() => widget.device.isSelected = false);
    } else {
      _deviceService.appendDevice(widget.device);
      setState(() => widget.device.isSelected = true);
    }
  }
}
