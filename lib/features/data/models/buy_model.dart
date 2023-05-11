// To parse this JSON data, do
//
//     final buyModel = buyModelFromJson(jsonString);

import 'dart:convert';

BuyModel buyModelFromJson(String str) => BuyModel.fromJson(json.decode(str));

String buyModelToJson(BuyModel data) => json.encode(data.toJson());

class BuyModel {
    final String status;
    final String activation;
    final String phone;
    final int timeStart;
    final int timeEnd;

    BuyModel({
        required this.status,
        required this.activation,
        required this.phone,
        required this.timeStart,
        required this.timeEnd,
    });

    factory BuyModel.fromJson(Map<String, dynamic> json) => BuyModel(
        status: json["status"],
        activation: json["activation"],
        phone: json["phone"],
        timeStart: json["timeStart"],
        timeEnd: json["timeEnd"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "activation": activation,
        "phone": phone,
        "timeStart": timeStart,
        "timeEnd": timeEnd,
    };
}
