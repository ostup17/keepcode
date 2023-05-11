// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

List<ServicesModel> servicesModelFromJson(String str) => List<ServicesModel>.from(json.decode(str).map((x) => ServicesModel.fromJson(x)));

String servicesModelToJson(List<ServicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesModel {
    final String shortName;
    final int sellTop;
    final bool forward;
    final int totalCount;
    final double minPrice;
    final double minFreePrice;
    final int? countWithFreePrice;
    final bool onlyRent;

    ServicesModel({
        required this.shortName,
        required this.sellTop,
        required this.forward,
        required this.totalCount,
        required this.minPrice,
        required this.minFreePrice,
        this.countWithFreePrice,
        required this.onlyRent,
    });

    factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        shortName: json["shortName"],
        sellTop: json["sellTop"],
        forward: json["forward"],
        totalCount: json["totalCount"],
        minPrice: json["minPrice"]?.toDouble(),
        minFreePrice: json["minFreePrice"]?.toDouble(),
        countWithFreePrice: json["countWithFreePrice"],
        onlyRent: json["onlyRent"],
    );

    Map<String, dynamic> toJson() => {
        "shortName": shortName,
        "sellTop": sellTop,
        "forward": forward,
        "totalCount": totalCount,
        "minPrice": minPrice,
        "minFreePrice": minFreePrice,
        "countWithFreePrice": countWithFreePrice,
        "onlyRent": onlyRent,
    };
}
