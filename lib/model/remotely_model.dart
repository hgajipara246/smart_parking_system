import 'dart:convert';
// HOME SCREEN MODEL //

/// model for work spases listview

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? carNumberPlate;
  String? gender;
  String? city;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.carNumberPlate,
    this.gender,
    this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        carNumberPlate: json["carNumberPlate"],
        gender: json["gender"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "carNumberPlate": carNumberPlate,
        "gender": gender,
        "city": city,
      };
}
