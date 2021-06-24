import 'package:flutter/material.dart';

class ShortcutModel {
  IconData icon;
  String name;
  String price;

  ShortcutModel({
    this.icon,
    this.name,
    @required this.price,
  });
}
