import 'dart:convert';

import 'package:led_app/model/Device.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/StorageKeys.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Device?> getCurrDevice() async {
    SharedPreferences prefs = await _prefs;
    String? value = prefs.getString(StorageKeys.deviceKey);
    if (value != null) {
      Map<String, dynamic> deviceData = jsonDecode(value);
      return Device.fromJson(deviceData);
    }
    return null;
  }

  Future<void> saveCurrDevice(Device device) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(StorageKeys.deviceKey, jsonEncode(device.toJSON()));
  }
}
