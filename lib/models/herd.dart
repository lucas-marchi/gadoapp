class Herd {
  int id;
  String name;

  Herd({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Herd.fromJson(Map<String, dynamic> json) {
    return Herd(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}