const String collectionHerd = 'Herds';
const String herdFieldId = 'id';
const String herdFieldName = 'name';

class Herd {
  String? id;
  String name;

  Herd({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      herdFieldId: id, 
      herdFieldName: name
    };
  }

  factory Herd.fromMap(Map<String, dynamic> map) =>
    Herd(
      id: map[herdFieldId], 
      name: map[herdFieldName]
  );
}
