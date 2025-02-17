import 'package:gadoapp/models/herd.dart';

class Bovine {
  int id;
  String name;
  String status;
  String gender;
  String? breed;
  double? weight;
  DateTime birth;
  final int herdId;
  final int? momId;
  final int? dadId;
  String? description;

  Bovine({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    this.breed,
    this.weight,
    required this.birth,
    required this.herdId,
    this.momId,
    this.dadId,
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
      'herd_id': herdId,
      'mom_id': momId,
      'dad_id': dadId,
    };
  }

  factory Bovine.fromJson(Map<String, dynamic> json) {
    return Bovine(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      gender: json['gender'],
      breed: json['breed'],
      weight: json['weight']?.toDouble(),
      birth: DateTime.parse(json['birth']),
      description: json['description'],
      herdId: json['herdId'],
      momId: json['momId'],
      dadId: json['dadId'],
    );
  }
}
