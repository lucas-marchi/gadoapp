const String collectionRace = 'Races';
const String raceFieldId = 'id';
const String raceFieldName = 'name';

class Race {
  String? id;
  String name;

  Race({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      raceFieldId: id, 
      raceFieldName: name
    };
  }

  factory Race.fromMap(Map<String, dynamic> map) =>
    Race(
      id: map[raceFieldId], 
      name: map[raceFieldName]
  );
}
