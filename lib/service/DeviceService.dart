import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  void write(List<Device> value) async {
    File file = await _initializeFile();
    file.writeAsString(jsonEncode(value));
  }
}
