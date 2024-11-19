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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      herdFieldId: id, 
      herdFieldName: name
    };
  }

  factory Herd.fromJson(Map<String, dynamic> map) =>
    Herd(
      id: map[herdFieldId], 
      name: map[herdFieldName]
  );
}