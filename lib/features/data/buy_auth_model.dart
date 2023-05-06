// To parse this JSON data, do
//
//     final buyAuthModel = buyAuthModelFromJson(jsonString);

import 'dart:convert';

BuyAuthModel buyAuthModelFromJson(String str) => BuyAuthModel.fromJson(json.decode(str));

String buyAuthModelToJson(BuyAuthModel data) => json.encode(data.toJson());

class BuyAuthModel {
    String sessionId;
    String balance;
    String cashback;
    String refreshToken;
    int userid;
    String email;
    dynamic telegramId;

    BuyAuthModel({
        required this.sessionId,
        required this.balance,
        required this.cashback,
        required this.refreshToken,
        required this.userid,
        required this.email,
        this.telegramId,
    });

    factory BuyAuthModel.fromJson(Map<String, dynamic> json) => BuyAuthModel(
        sessionId: json["sessionId"],
        balance: json["balance"],
        cashback: json["cashback"],
        refreshToken: json["refresh_token"],
        userid: json["userid"],
        email: json["email"],
        telegramId: json["telegram_id"],
    );

    Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "balance": balance,
        "cashback": cashback,
        "refresh_token": refreshToken,
        "userid": userid,
        "email": email,
        "telegram_id": telegramId,
    };
}
