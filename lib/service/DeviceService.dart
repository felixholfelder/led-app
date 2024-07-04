import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../model/Device.dart';

class DeviceService {
  Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final file = File("${localDirectory.path}/devices.json");

    if (!await file.exists() || file.readAsStringSync() == "[]") {
      final initialContent = await rootBundle.loadString("assets/devices.json");
      await file.create();
      await file.writeAsString(initialContent);
    }

    return file;
  }

  Future<List<Device>> getDevices() async {
    File file = await _initializeFile();
    final String response = file.readAsStringSync();
    final List<dynamic> body = jsonDecode(response);

    return body.map((dynamic item) => Device.fromJson(item)).toList();
  }

  Future<List<Device>> getSelectedDevices() async {
    File file = await _initializeFile();
    final String response = file.readAsStringSync();
    final List<dynamic> body = jsonDecode(response);

    var list = body.map((dynamic item) => Device.fromJson(item)).toList();
    return list.where((element) => element.isSelected == true).toList();
  }

  Future<List<Device>> saveDevice(Device device) async {
    List<Device> devices = await getDevices();

    devices.add(device);
    write(devices);

    return devices;
  }

  Future<List<Device>> deleteDevice(Device device) async {
    List<Device> devices = await getDevices();

    devices.removeWhere((element) => element.endpoint == device.endpoint);
    write(devices);

    return devices;
  }

  Future<void> appendDevice(Device device) async {
    List<Device> list = await getDevices();

    list.forEach((el) => {
      if (el.endpoint == device.endpoint) el.isSelected = true
    });

    write(list);
  }

  Future<void> removeDevice(Device device) async {
    List<Device> list = await getDevices();

    list.forEach((el) => {
      if (el.endpoint == device.endpoint) el.isSelected = false
    });

    write(list);
  }

  void write(List<Device> list) async {
    File file = await _initializeFile();
    file.writeAsString(jsonEncode(list));
  }

  static Future<void> showNoSelectionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Du hast kein Gerät ausgewählt"),
            actionsOverflowButtonSpacing: 20,
            actions: [
              //TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Abbrechen")),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white),
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
