class LabourModel {
  String name;
  String field;

  LabourModel({required this.name, required this.field});

  factory LabourModel.mapToObj(Map<String, dynamic> map) => LabourModel(
        name: map['name'],
        field: map['field'],
      );

  Map<String, dynamic> objToMap() => {
        'name': name,
        'field': field,
      };
}
