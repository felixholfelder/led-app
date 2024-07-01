class Device {
  final String name;
  final String endpoint;

  Device({required this.name, required this.endpoint});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      name: json['name'] as String,
      endpoint: json['endpoint'] as String,
    );
  }

  Map<String, dynamic> toJSON() => {
    'name': name,
    'endpoint': endpoint
  };
}