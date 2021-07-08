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
