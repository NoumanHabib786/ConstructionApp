class UserModel {
  String name;
  String password;

  UserModel({required this.name, required this.password});

  factory UserModel.mapToObj(Map<String, dynamic> map) => UserModel(
        name: map['name'],
        password: map['password'],
      );

  Map<String, dynamic> objToMap() => {
        'name': name,
        'password': password,
      };
}
