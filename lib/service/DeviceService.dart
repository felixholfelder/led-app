import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../model/Device.dart';

class DeviceService {

  Future<File> _initializeFile() async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final file = File("${localDirectory.path}/devices.json");

    if (file.readAsStringSync() == "[]") {
      final initialContent = await rootBundle.loadString("assets/devices.json");
      await file.create();
      await file.writeAsString(initialContent);
    }

    return file;
  }


  Future<List<Device>> loadDevices() async {
    File file = await _initializeFile();
    final String response = file.readAsStringSync();
    final List<dynamic> body = jsonDecode(response);

    return body.map((dynamic item) => Device.fromJson(item)).toList();
  }

  Future<void> appendDevice(Device device) async {
    List<Device> list = await loadDevices();

    List<Device> d = list.where((element) => element.endpoint == device.endpoint).toList();

    d.forEach((element) => element.isSelected = true);

    write(d);
  }

  Future<void> removeDevice(Device device) async {
    List<Device> list = await loadDevices();
    list.removeWhere((element) => element.endpoint == device.endpoint);

    write(list);
  }

  void write(List<Device> value) async {
    File file = await _initializeFile();
    file.writeAsString(jsonEncode(value));
  }
}