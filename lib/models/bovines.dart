const String collectionBovine = 'Bovines';
const String bovineFieldId = 'id';
const String bovineFieldName = 'name';

class Bovine {
  String? id;
  String? name;

  Bovine({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      bovineFieldId: id, 
      bovineFieldName: name
    };
  }

  factory Bovine.fromJson(Map<String, dynamic> map) =>
    Bovine(
      id: map[bovineFieldId], 
      name: map[bovineFieldName]
  );
}
