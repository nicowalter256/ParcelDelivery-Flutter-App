// To parse this JSON data, do
//
//     final packages = packagesFromJson(jsonString);

import 'dart:convert';

Packages packagesFromJson(String str) => Packages.fromJson(json.decode(str));

String packagesToJson(Packages data) => json.encode(data.toJson());

class Packages {
  Packages({
    required this.currentPage,
    required this.data,
  });

  int currentPage;
  List<Datum> data;

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.packageName,
    required this.qantity,
    required this.packageStatus,
    required this.receiverName,
    required this.senderId,
    required this.receiverEmail,
    required this.receiverContact,
    required this.amountToPay,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryLocation,
    required this.description,
  });

  int id;
  String packageName;
  dynamic qantity;
  String packageStatus;
  String receiverName;
  int senderId;
  String receiverEmail;
  String receiverContact;
  int amountToPay;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryLocation;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        packageName: json["package_name"],
        qantity: json["qantity"],
        packageStatus: json["package_status"],
        receiverName: json["receiver_name"],
        senderId: json["sender_id"],
        receiverEmail: json["receiver_email"],
        receiverContact: json["receiver_contact"],
        amountToPay: json["amount_to_pay"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryLocation: json["delivery_location"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "qantity": qantity,
        "package_status": packageStatus,
        "receiver_name": receiverName,
        "sender_id": senderId,
        "receiver_email": receiverEmail,
        "receiver_contact": receiverContact,
        "amount_to_pay": amountToPay,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_location": deliveryLocation,
        "description": description
      };
}
