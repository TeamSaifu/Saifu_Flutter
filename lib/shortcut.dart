import 'package:flutter/material.dart';

import 'package:saifu/shortcut_model.dart';

import 'package:intl/intl.dart';

class ShortcutPage extends StatelessWidget {
  final formatter = NumberFormat("#,###");

  final List<ShortcutItemModel> _shortcutList = [
    ShortcutItemModel(price: 1000, icon: Icons.face, name: '住田'),
    ShortcutItemModel(price: 500, icon: Icons.money, name: '石ころ'),
    ShortcutItemModel(price: 35100, icon: Icons.radio, name: 'なんか電化'),
  ];

  Widget _shortcutItem({int index}) {
    return Container(
      height: 70,
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Icon(_shortcutList[index].icon),
          ),
          Expanded(
            flex: 4,
            child: Text(_shortcutList[index].name),
          ),
          Expanded(
            flex: 4,
            child: Text('￥' + formatter.format(_shortcutList[index].price)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ショートカット'),
      ),
      body: ListView.builder(
          itemCount: _shortcutList.length,
          itemBuilder: (BuildContext context, int index) {
            return _shortcutItem(index: index);
          }),
    );
  }
}
