import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:via_cep_flutter/models/cep.dart';
import 'package:via_cep_flutter/via_cep_flutter.dart';

class ResultCep {
  String cep;
  String logradouro;
  String bairro;
  String localidade;
  String uf;


  ResultCep({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory ResultCep.fromJson(String str) => ResultCep.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultCep.fromMap(Map<String, dynamic> json) => ResultCep(
    cep: json["cep"],
    logradouro: json["logradouro"],
    bairro: json["bairro"],
    localidade: json["localidade"],
    uf: json["uf"],
  );

  Map<String, dynamic> toMap() => {
    "CEP": cep,
    "LOGRADOURO": logradouro,
    "BAIRRO": bairro,
    "CIDADE": localidade,
    "ESTADO": uf,
  };

}
