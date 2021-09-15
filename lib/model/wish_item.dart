import 'package:flutter/foundation.dart';

class WishItem {
  final int id;
  final int price;
  final String name;
  final String url;
  final String picture;

  const WishItem({
    @required this.id,
    @required this.price,
    @required this.name,
    @required this.url,
    @required this.picture,
  });

  int get getId => id;
  int get getPrice => price;
  String get getName => '$name';
  String get getURL => '$url';
  String get getPicture => '$picture';

  factory WishItem.fromMap(Map<String, dynamic> json) => WishItem(
    id: json["id"],
    price: json["price"],
    name: json["name"],
    url: json["url"],
    picture: json["picture"],
  );
}
