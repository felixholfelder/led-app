class Device {
  final String name;
  final String endpoint;
  bool isSelected;

  Device({required this.name, required this.endpoint, required this.isSelected});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      name: json['name'] as String,
      endpoint: json['endpoint'] as String,
      isSelected: json['isSelected'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'endpoint': endpoint, 'isSelected': isSelected};

  @override
  String toString() => "{'name': $name, 'endpoint': $endpoint, 'isSelected': $isSelected}";
}
