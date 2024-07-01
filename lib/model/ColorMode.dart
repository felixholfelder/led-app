class ColorMode {
  final String name;
  final String key;
  final int id;

  ColorMode({required this.name, required this.key, required this.id});

  factory ColorMode.fromJson(Map<String, dynamic> json) {
    return ColorMode(
      name: json['name'] as String,
      key: json['key'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJSON() => {
    'name': name,
    'key': key,
    'id': id
  };
}