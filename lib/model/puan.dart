import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class Puan {
  int puan;

  Puan({required this.puan});

  factory Puan.fromJson(Map<String, dynamic> json) {
    return Puan(
      puan: json["puan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "puan": puan,
    };
  }
}