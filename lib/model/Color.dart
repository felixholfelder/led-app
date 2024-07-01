class Color {
  final String hex;

  Color({required this.hex});

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      hex: json['hex'] as String,
    );
  }

  Map<String, dynamic> toJSON() => {
    'hex': hex,
  };
}