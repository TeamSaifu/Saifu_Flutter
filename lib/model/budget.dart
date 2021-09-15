import 'package:flutter/foundation.dart';

class Budget {
  final int id;
  final int price;
  final String name;
  final int sign;

  const Budget({
    @required this.id,
    @required this.price,
    @required this.name,
    @required this.sign,
  });

  int get getId => id;
  int get getPrice => price;
  String get getName => '$name';

  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
    id: json["id"],
    price: json["price"],
    name: json["name"],
    sign: json["sign"],
  );
}
