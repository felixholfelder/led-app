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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _endpointController = TextEditingController();

  List<Device> devices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreationDeviceDialog(context),
        child: const Icon(Icons.add),
      ),
      body: devices.isNotEmpty
          ? ListView.builder(
              itemCount: devices.length, itemBuilder: (context, index) => DeviceElement(device: devices[index], onLongClick: (Device device) => _openDeleteDeviceDialog(context, device)))
          : const Text("Keine Geräte vorhanden"),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadDevices();
  }

  Future<void> _openCreationDeviceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Neues Gerät"),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Abbrechen")),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _saveDevice();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                child: const Text("Speichern"),
              ),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  TextField(controller: _nameController),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Endpoint", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  TextField(controller: _endpointController),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> _openDeleteDeviceDialog(BuildContext context, Device device) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("${device.name} löschen?"),
            actionsOverflowButtonSpacing: 20,
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Abbrechen")),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteDevice(device);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                child: const Text("Löschen"),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _loadDevices() async {
    devices = await _deviceService.getDevices();
    setState(() => devices);
  }

  Future<void> _saveDevice() async {
    var name = _nameController.text;
    var endpoint = _endpointController.text;
    var isSelected = false;

    Device device = Device(name: name, endpoint: endpoint, isSelected: isSelected);

    devices = await _deviceService.saveDevice(device);
    setState(() => devices);
  }

  Future<void> _deleteDevice(Device device) async {
    devices = await _deviceService.deleteDevice(device);
    setState(() => devices);
  }
}
