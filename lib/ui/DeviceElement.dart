import 'package:flutter/material.dart';
import 'package:led_app/model/Device.dart';

class DeviceElement extends StatefulWidget {
  const DeviceElement({super.key, required this.device, required this.onclick});

  final Device device;
  final VoidCallback onclick;

  @override
  State<DeviceElement> createState() => _DeviceElementState();
}

class _DeviceElementState extends State<DeviceElement> {
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
          onTap: () => widget.onclick(),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: widget.device.isSelected ? const Icon(Icons.lightbulb, size: 28) : const Icon(Icons.lightbulb_outline, size: 28),
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
}
