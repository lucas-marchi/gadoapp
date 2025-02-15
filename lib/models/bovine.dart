import 'package:gadoapp/models/herd.dart';

class Bovine {
  final int? id;
  final String name;
  final String status;
  final String gender;
  final String? breed;
  final double? weight;
  final DateTime birth;
  final Herd? herd;
  final Bovine? mom;
  final Bovine? dad;
  final String? description;

  Bovine({
    this.id,
    required this.name,
    required this.status,
    required this.gender,
    this.breed,
    this.weight,
    required this.birth,
    this.herd,
    this.mom,
    this.dad,
    this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bovine &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
  return {
    'id': id,
    'name': name,
    'status': status,
    'gender': gender,
    'breed': breed,
    'weight': weight,
    'birth': birth.toIso8601String(),
    'herd': herd != null ? herd!.toJson() : null,
    'mom': mom != null ? mom!.toJson() : null,
    'dad': dad != null ? dad!.toJson() : null,
    'description': description,
  };
}

  factory Bovine.fromJson(Map<String, dynamic> json) {
    return Bovine(
      id: json['id'] as int?,
      name: json['name'] as String,
      status: json['status'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String?,
      weight: json['weight'] as double?,
      birth: DateTime.parse(json['birth'] as String),
      //herd: json['herd'] != null ? Herd.fromJson(json['herd']) : null,
      mom: json['mom'] != null ? Bovine.fromJson(json['mom']) : null,
      dad: json['dad'] != null ? Bovine.fromJson(json['dad']) : null,
      description: json['description'] as String?,
    );
  }

  // Método copyWith para atualizações
  Bovine copyWith({
    int? id,
    String? name,
    String? status,
    String? gender,
    String? breed,
    double? weight,
    DateTime? birth,
    Herd? herd,
    Bovine? mom,
    Bovine? dad,
    String? description,
  }) {
    return Bovine(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      breed: breed ?? this.breed,
      weight: weight ?? this.weight,
      birth: birth ?? this.birth,
      herd: herd ?? this.herd,
      mom: mom ?? this.mom,
      dad: dad ?? this.dad,
      description: description ?? this.description,
    );
  }
}