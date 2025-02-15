import 'package:gadoapp/models/herd.dart';

class Bovine {
  int id;
  String name;
  String status;
  String gender;
  String? breed;
  double? weight;
  DateTime birth;
  Herd herd;
  Bovine? mom;
  Bovine? dad;
  String? description;

  Bovine({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    this.breed,
    this.weight,
    required this.birth,
    required this.herd,
    this.mom,
    this.dad,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'gender': gender,
      'breed': breed,
      'weight': weight,
      'birth': birth.toIso8601String(),
      'description': description,
      'herd_id': herd.id,
      'mom_id': mom?.id,
      'dad_id': dad?.id,
    };
  }

  factory Bovine.fromJson(Map<String, dynamic> json) {
    return Bovine(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      gender: json['gender'] as String,
      breed: json['breed'] as String?,
      weight: json['weight'] as double?,
      birth: DateTime.parse(json['birth'] as String),
      herd: json['herd_id'] != null ? Herd.fromJson(json['herd']) : null,
      mom: json['mom_id'] != null ? Bovine.fromJson(json['mom']) : null,
      dad: json['dad_id'] != null ? Bovine.fromJson(json['dad']) : null,
      description: json['description'] as String?,
    );
  }
}
