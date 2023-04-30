class MaterialModel {
  String name;
  String price;

  MaterialModel({
    required this.name,
    required this.price,
  });

  factory MaterialModel.mapToObj(Map<String, dynamic> map) => MaterialModel(
        name: map['name'],
        price: map['price'],
      );

  Map<String, dynamic> objToMap() => {
        'name': name,
        'price': price,
      };
}
