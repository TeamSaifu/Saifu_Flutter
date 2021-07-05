import 'package:flutter/material.dart';

class ShortcutItemModel {
  IconData icon;
  String name;
  String price;

  ShortcutItemModel({
    this.icon,
    this.name,
    @required this.price,
  });
}