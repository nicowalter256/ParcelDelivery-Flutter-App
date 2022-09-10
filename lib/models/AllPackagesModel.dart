// To parse this JSON data, do
//
//     final allPackagesModel = allPackagesModelFromJson(jsonString);

import 'dart:convert';

AllPackagesModel allPackagesModelFromJson(String str) =>
    AllPackagesModel.fromJson(json.decode(str));

String allPackagesModelToJson(AllPackagesModel data) =>
    json.encode(data.toJson());

class AllPackagesModel {
  AllPackagesModel({
    required this.currentPage,
    required this.data,
  });

  int currentPage;
  List<Datum> data;

  factory AllPackagesModel.fromJson(Map<String, dynamic> json) =>
      AllPackagesModel(
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
    required this.pickUpLocation,
    required this.categoryId,
    required this.packageStatus,
    required this.receiverName,
    required this.packageImage,
    required this.packageCenterId,
    required this.senderId,
    required this.receiverEmail,
    required this.receiverContact,
    required this.amountToPay,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryLocation,
    required this.sender,
  });

  int id;
  String packageName;
  dynamic qantity;
  String pickUpLocation;
  dynamic categoryId;
  String packageStatus;
  String receiverName;
  dynamic packageImage;
  int packageCenterId;
  int senderId;
  String receiverEmail;
  String receiverContact;
  int amountToPay;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryLocation;
  Sender sender;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        packageName: json["package_name"],
        qantity: json["qantity"],
        pickUpLocation: json["pick_up_location"],
        categoryId: json["category_id"],
        packageStatus: json["package_status"],
        receiverName: json["receiver_name"],
        packageImage: json["package_image"],
        packageCenterId: json["package_center_id"] == null
            ? null
            : json["package_center_id"],
        senderId: json["sender_id"],
        receiverEmail: json["receiver_email"],
        receiverContact: json["receiver_contact"],
        amountToPay: json["amount_to_pay"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deliveryLocation: json["delivery_location"],
        sender: Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "qantity": qantity,
        "pick_up_location": pickUpLocation,
        "category_id": categoryId,
        "package_status": packageStatus,
        "receiver_name": receiverName,
        "package_image": packageImage,
        "package_center_id": packageCenterId == null ? null : packageCenterId,
        "sender_id": senderId,
        "receiver_email": receiverEmail,
        "receiver_contact": receiverContact,
        "amount_to_pay": amountToPay,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "delivery_location": deliveryLocation,
        "sender": sender.toJson(),
      };
}

class Sender {
  Sender({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.contact,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  int id;
  String firstname;
  String lastname;
  String contact;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  String role;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        contact: json["contact"],
        email: json["email"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "contact": contact,
        "email": email,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": role,
      };
}
