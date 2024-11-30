import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
//
// class PaymentModel {
//   String selectedDate;
//   int slotNumber;
//   String startTime;
//   String endTime;
//   int total;
//   String qrCodeUrl;
//
//   PaymentModel({
//     required this.selectedDate,
//     required this.slotNumber,
//     required this.startTime,
//     required this.endTime,
//     required this.total,
//     required this.qrCodeUrl,
//   });
//
//   factory PaymentModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return PaymentModel(
//       selectedDate: data['selectedDate'] ?? '',
//       slotNumber: data['slotNumber'] ?? 0,
//       startTime: data['startTime'] ?? '',
//       endTime: data['endTime'] ?? '',
//       total: data['total'] ?? 0,
//       qrCodeUrl: data['qrCodeUrl'] ?? '',
//     );
//   }
// }

// class PaymentModel {
//   String selectedDate;
//   int slotNumber;
//   String startTime;
//   String endTime;
//   int total;
//   String qrCodeUrl;
//
//   PaymentModel({
//     required this.selectedDate,
//     required this.slotNumber,
//     required this.startTime,
//     required this.endTime,
//     required this.total,
//     required this.qrCodeUrl,
//   });
//
//   factory PaymentModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return PaymentModel(
//       selectedDate: data['selectedDate'] ?? '',
//       slotNumber: data['slotNumber'] ?? 0,
//       startTime: data['startTime'] ?? '',
//       endTime: data['endTime'] ?? '',
//       total: data['total'] ?? 0,
//       qrCodeUrl: data['qrCodeUrl'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "selectedDate": selectedDate,
//         "slotNumber": slotNumber,
//         "startTime": startTime,
//         "endTime": endTime,
//         "total": total,
//         "qrCodeUrl": qrCodeUrl,
//       };
//
//   factory PaymentModel.fromJson(Map<String, dynamic> json) {
//     return PaymentModel(
//       selectedDate: json["selectedDate"],
//       slotNumber: json["slotNumber"],
//       startTime: json["startTime"],
//       endTime: json["endTime"],
//       total: json["total"],
//       qrCodeUrl: json["qrCodeUrl"],
//     );
//   }
// }

class PaymentModel {
  String id; // Add an id property
  String selectedDate;
  int slotNumber;
  String startTime;
  String endTime;
  int total;
  String qrCodeUrl;

  PaymentModel({
    required this.id, // Initialize the id
    required this.selectedDate,
    required this.slotNumber,
    required this.startTime,
    required this.endTime,
    required this.total,
    required this.qrCodeUrl,
  });

  factory PaymentModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PaymentModel(
      id: snapshot.id, // Set the id from the document ID
      selectedDate: data['selectedDate'] ?? '',
      slotNumber: data['slotNumber'] ?? 0,
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
      total: data['total'] ?? 0,
      qrCodeUrl: data['qrCodeUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "selectedDate": selectedDate,
        "slotNumber": slotNumber,
        "startTime": startTime,
        "endTime": endTime,
        "total": total,
        "qrCodeUrl": qrCodeUrl,
      };

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json["id"], // Include id in fromJson method
      selectedDate: json["selectedDate"],
      slotNumber: json["slotNumber"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      total: json["total"],
      qrCodeUrl: json["qrCodeUrl"],
    );
  }
}
