// To parse this JSON data, do
//
//     final buyErrorModel = buyErrorModelFromJson(jsonString);

import 'dart:convert';

BuyErrorModel buyErrorModelFromJson(String str) => BuyErrorModel.fromJson(json.decode(str));

String buyErrorModelToJson(BuyErrorModel data) => json.encode(data.toJson());

class BuyErrorModel {
    final String status;
    final String error;

    BuyErrorModel({
        required this.status,
        required this.error,
    });

    factory BuyErrorModel.fromJson(Map<String, dynamic> json) => BuyErrorModel(
        status: json["status"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
    };
}
