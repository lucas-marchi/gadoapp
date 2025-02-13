import 'package:gadoapp/models/herd.dart';

class Bovine {
  final int id;
  final String name;
  final String status;
  final String gender;
  final String? breed;
  final Herd? herd;
  final num? weight;
  final DateTime birth;
  final Bovine? dad;
  final Bovine? mom;
  final String? description;

  Bovine({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    this.breed,
    this.herd,
    this.weight,
    required this.birth,
    this.dad,
    this.mom,
    this.description,
  });
}