import 'package:flutter/material.dart';

class log extends StatelessWidget {
  // 汎用的なページ 下のやつ渡すとなんか出る
  // pannelColor : 画面色
  // title : 真ん中の文字
  final Color pannelColor;
  final String title;

  log({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {
    //各データ用配列
    var icon = [
      "#",
      "%",
    ];
    var date = ["03.23", "03.24"];
    var name = ["お弁当", "家電製品購入"];
    var price = ["¥620", "¥230,000"];

    return MaterialApp(
        //右上デバッグを消すやつ
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView.builder(
          // listの上限を設定
          itemCount: icon.length,
          itemBuilder: (BuildContext context, int index) {
            return _messageItem(
                icon[index], date[index], price[index], name[index]);
          },
        )));
  }
}

Widget _messageItem(String icon, String date, String price, String name) {
  // 項目をスワイプすると削除する
  return Dismissible(
    key: Key("some id"),

    // end to startの背景
    background: Container(color: Colors.red),
    secondaryBackground: Container(color: Colors.red),

    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      // スワイプ後に実行される（削除処理などを書く）
      print('onDismissed');
    },
    child: Card(
      //現在は横並び均等、文字数によりずれるので要調整
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            child: Text(
          date,
          style: TextStyle(fontSize: 20),
        )),
        Container(
          child: Text(icon, style: TextStyle(fontSize: 20)),
        ),
        Container(
          child: Text(
            name,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          child: Text(
            price,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    )),
  );
}
