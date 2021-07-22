import 'package:flutter/material.dart';

class WishItemModel {
  String item;
  int price;
  String url;

  WishItemModel({
    @required this.item,
    this.price,
    this.url,
  });
}