import 'dart:async';

import 'package:led_app/service/DeviceService.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  static MqttServerClient client = MqttServerClient("broker.hivemq.com", "felix_client_text_1234");
  static String currTopic = "";
  static final DeviceService _deviceService = DeviceService();

  static void connect() async {
    client.logging(on: true); // Enable logging for debugging

    // client.setProtocolV31();
    client.secure = true;
    client.port = 8883;
    client.keepAlivePeriod = 60; // Increase keep-alive period to 60 seconds
    client.connectTimeoutPeriod = 5000; // Increase timeout to 5 seconds

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    try {
      final status = await client.connect();
      if (status!.state == MqttConnectionState.connected) {
        print('MQTT: Connected');
      } else {
        print('MQTT: Connection failed - status: ${status.state}');
        client.disconnect();
      }
    } on NoConnectionException catch (e) {
      print('NoConnectionException: $e');
      client.disconnect();
    } on Exception catch (e) {
      print('EXCEPTION: $e');
      client.disconnect();
    }
  }

  static void onConnected() {
    print("MQTT: Connected successfully");
    subscribe("/devices/felix/desk");
  }

  static void onDisconnected() {
    print("MQTT: Disconnected");
  }

  static void onSubscribed(String topic) {
    print("MQTT: Subscribed to $topic");
  }

  static void onUnsubscribed(String? topic) {
    print("MQTT: Unsubscribed from $topic");
  }

  static void pong() {
    print('MQTT: Pong response received');
  }

  static void subscribe(String topic) {
    currTopic = topic;
    client.subscribe(currTopic, MqttQos.atMostOnce);
    send("Hello from mqtt_client");
  }

  static void unsubscribe() {
    if (currTopic.isNotEmpty) {
      client.unsubscribe(currTopic);
    }
  }

  static Future<bool> send(String message) async {
    if (_isConnected()) return false;

    var devices = await _deviceService.getSelectedDevices();
    if (devices.isEmpty) return false;


    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    devices.forEach((el) => client.publishMessage(el.endpoint, MqttQos.exactlyOnce, builder.payload!));
    return true;
  }

  static bool _isConnected() => client.connectionStatus!.state != MqttConnectionState.connected;
}
