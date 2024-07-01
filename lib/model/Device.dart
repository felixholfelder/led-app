class Device {
  final String name;
  final String endpoint;
  bool isSelected;

  Device({required this.name, required this.endpoint, required this.isSelected});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      name: json['name'] as String,
      endpoint: json['endpoint'] as String,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJSON() => {
    'name': name,
    'endpoint': endpoint
  };
}