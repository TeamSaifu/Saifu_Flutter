import 'package:flutter/material.dart';

class WishItemModel {
  String item;
  String price;
  String url;

  WishItemModel({
    @required this.item,
    this.price,
    this.url,
  });
}