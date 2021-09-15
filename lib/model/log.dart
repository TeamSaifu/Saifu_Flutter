import 'package:flutter/foundation.dart';

class PayLog {
  final int id;
  final DateTime inputDate;
  final DateTime payDate;
  final int price;
  final String name;
  final int category;
  final String picture;
  final int sign;
  final int splitCount;

  const PayLog({
    @required this.id,
    @required this.inputDate,
    @required this.payDate,
    @required this.price,
    @required this.name,
    @required this.category,
    @required this.picture,
    @required this.sign,
    @required this.splitCount,
  });

  int get getId => id;
  DateTime get getPayDate => payDate;
  int get getPrice => price;
  String get getName => '$name';
  int get getCategory => category;
  String get getPicture => '$picture';

  factory PayLog.fromMap(Map<String, dynamic> json) => PayLog(
    id: json["id"],
    inputDate: DateTime.parse(json["input_date"]).toLocal(),
    payDate: DateTime.parse(json["pay_date"]).toLocal(),
    price: json["price"],
    name: json["name"],
    category: json["category"],
    picture: json["picture"],
    sign: json["sign"],
    splitCount: json["split_count"],
  );
}
