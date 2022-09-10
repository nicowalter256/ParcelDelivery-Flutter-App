// To parse this JSON data, do
//
//     final packageCenters = packageCentersFromJson(jsonString);

import 'dart:convert';

PackageCenters packageCentersFromJson(String str) =>
    PackageCenters.fromJson(json.decode(str));

String packageCentersToJson(PackageCenters data) => json.encode(data.toJson());

class PackageCenters {
  PackageCenters({
    required this.currentPage,
    required this.data,
  });

  int currentPage;
  List<Datum> data;

  factory PackageCenters.fromJson(Map<String, dynamic> json) => PackageCenters(
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
    required this.centerCode,
    required this.centerName,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String centerCode;
  String centerName;
  String address;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        centerCode: json["center_code"],
        centerName: json["center_name"],
        address: json["address"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "center_code": centerCode,
        "center_name": centerName,
        "address": address,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
