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

  static fromJson(json) {}
}