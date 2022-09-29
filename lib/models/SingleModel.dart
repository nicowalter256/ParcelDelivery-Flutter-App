// To parse this JSON data, do
//
//     final singlePackage = singlePackageFromJson(jsonString);

import 'dart:convert';

SinglePackage singlePackageFromJson(String str) =>
    SinglePackage.fromJson(json.decode(str));

String singlePackageToJson(SinglePackage data) => json.encode(data.toJson());

class SinglePackage {
  SinglePackage({
    required this.id,
    required this.packageName,
    required this.qantity,
    required this.pickUpLocation,
    required this.packageStatus,
    required this.receiverName,
    required this.packageImage,
    required this.senderId,
    required this.receiverEmail,
    required this.receiverContact,
    required this.amountToPay,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryLocation,
  });

  int id;
  String packageName;
  String qantity;
  String pickUpLocation;
  String packageStatus;
  String receiverName;
  String packageImage;
  int senderId;
  String receiverEmail;
  String receiverContact;
  int amountToPay;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryLocation;

  factory SinglePackage.fromJson(Map<String, dynamic> json) => SinglePackage(
        id: json["id"],
        packageName: json["package_name"],
        qantity: json["qantity"],
        pickUpLocation: json["pick_up_location"],
        packageStatus: json["package_status"],
        receiverName: json["receiver_name"],
        packageImage: json["package_image"],
        senderId: json["sender_id"],
        receiverEmail: json["receiver_email"],
        receiverContact: json["receiver_contact"],
        amountToPay: json["amount_to_pay"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryLocation: json["delivery_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "qantity": qantity,
        "pick_up_location": pickUpLocation,
        "package_status": packageStatus,
        "receiver_name": receiverName,
        "package_image": packageImage,
        "sender_id": senderId,
        "receiver_email": receiverEmail,
        "receiver_contact": receiverContact,
        "amount_to_pay": amountToPay,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_location": deliveryLocation,
      };
}
