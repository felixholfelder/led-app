import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  static MqttServerClient client = MqttServerClient("broker.hivemq.com", "felix_client_text_1234");
  static String currTopic = "";

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

  static void send(String message) {
    print("STATUS: ${client.connectionStatus!.state}");
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(currTopic, MqttQos.exactlyOnce, builder.payload!);
      print("MQTT: Message sent");
    } else {
      print("MQTT: Cannot send, client not connected");
    }
  }
}
