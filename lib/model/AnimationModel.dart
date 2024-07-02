class AnimationModel {
  final String name;
  final String key;
  final int id;

  AnimationModel({required this.name, required this.key, required this.id});

  factory AnimationModel.fromJson(Map<String, dynamic> json) {
    return AnimationModel(
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