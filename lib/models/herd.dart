class Herd {
  int id;
  String name;

  Herd({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Herd &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}