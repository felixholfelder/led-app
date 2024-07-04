class AnimationModel {
  final String name;
  final String key;
  final int id;
  bool isSelected;

  AnimationModel({required this.name, required this.key, required this.id, required this.isSelected});

  factory AnimationModel.fromJson(Map<String, dynamic> json) {
    return AnimationModel(
      name: json['name'] as String,
      key: json['key'] as String,
      id: json['id'] as int,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'key': key, 'id': id};
}
