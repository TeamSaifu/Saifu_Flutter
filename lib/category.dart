import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  // 汎用的なページ 下のやつ渡すとなんか出る
  // pannelColor : 画面色
  // title : 真ん中の文字
  final Color pannelColor;
  final String title;

  // カテゴリ一覧
  final category = [
    "食費",
    "娯楽費",
    "通信費",
    "交通費",
    "医療費",
    "旅行日",
    "水道光熱費",
    "日用品費",
    "住居費",
    "給料",
    "ボーナス",
    "臨時収入",
    "その他"
  ];

  Category({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('カテゴリ一覧')),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.g_translate),
                title: Text(
                  category[index],
                  style: TextStyle(fontSize: 28),
                ),
              ),
            );
          },
          itemCount: category.length,
        ));
  }
}
