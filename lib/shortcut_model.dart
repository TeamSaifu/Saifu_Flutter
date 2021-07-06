import 'package:flutter/material.dart';

class ShortcutItemModel {
  IconData icon;
  String name;
  int price;

  ShortcutItemModel({
    this.icon,
    this.name,
    @required this.price,
  });
}