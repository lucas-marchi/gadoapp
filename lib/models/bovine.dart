import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gadoapp/models/herds.dart';

part 'bovine.freezed.dart';
part 'bovine.g.dart';

@unfreezed
class Bovine with _$Bovine {
  factory Bovine({
    String? id,
    String? name,
    required String status,
    required String gender,
    String? breed,
    Herd? herd,
    num? weight,
    required DateTime birth,
    Bovine? dad,
    Bovine? mom,
    String? description,
  }) = _Bovine;

  factory Bovine.fromJson(Map<String, dynamic> json) => 
    _$BovineFromJson(json);
}