// To parse this JSON data, do
//
//     final translationsModel = translationsModelFromJson(jsonString);

import 'dart:convert';

TranslationsModel translationsModelFromJson(String str) => TranslationsModel.fromJson(json.decode(str));

String translationsModelToJson(TranslationsModel data) => json.encode(data.toJson());

class TranslationsModel {
    Map<String, Operator> operators;

    TranslationsModel({
        required this.operators,
    });

    factory TranslationsModel.fromJson(Map<String, dynamic> json) => TranslationsModel(
        operators: Map.from(json["operators"]).map((k, v) => MapEntry<String, Operator>(k, Operator.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "operators": Map.from(operators).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Operator {
    Azerfon? azerfon;
    Azerfon? humans;
    Azerfon? mts;
    Azerfon? mdc;
    Azerfon? best;
    Azerfon? life;
    Azerfon? optus;
    Azerfon? vodafone;
    Azerfon? telstra;

    Operator({
        this.azerfon,
        this.humans,
        this.mts,
        this.mdc,
        this.best,
        this.life,
        this.optus,
        this.vodafone,
        this.telstra,
    });

    factory Operator.fromJson(Map<String, dynamic> json) => Operator(
        azerfon: json["azerfon"] == null ? null : Azerfon.fromJson(json["azerfon"]),
        humans: json["humans"] == null ? null : Azerfon.fromJson(json["humans"]),
        mts: json["mts"] == null ? null : Azerfon.fromJson(json["mts"]),
        mdc: json["mdc"] == null ? null : Azerfon.fromJson(json["mdc"]),
        best: json["best"] == null ? null : Azerfon.fromJson(json["best"]),
        life: json["life"] == null ? null : Azerfon.fromJson(json["life"]),
        optus: json["optus"] == null ? null : Azerfon.fromJson(json["optus"]),
        vodafone: json["vodafone"] == null ? null : Azerfon.fromJson(json["vodafone"]),
        telstra: json["telstra"] == null ? null : Azerfon.fromJson(json["telstra"]),
    );

    Map<String, dynamic> toJson() => {
        "azerfon": azerfon?.toJson(),
        "humans": humans?.toJson(),
        "mts": mts?.toJson(),
        "mdc": mdc?.toJson(),
        "best": best?.toJson(),
        "life": life?.toJson(),
        "optus": optus?.toJson(),
        "vodafone": vodafone?.toJson(),
        "telstra": telstra?.toJson(),
    };
}

class Azerfon {
    String ru;
    String en;
    String cn;

    Azerfon({
        required this.ru,
        required this.en,
        required this.cn,
    });

    factory Azerfon.fromJson(Map<String, dynamic> json) => Azerfon(
        ru: json["ru"],
        en: json["en"],
        cn: json["cn"],
    );

    Map<String, dynamic> toJson() => {
        "ru": ru,
        "en": en,
        "cn": cn,
    };
}
