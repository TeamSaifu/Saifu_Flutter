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
    var icon = ["#", "%", "&"];
    var date = ["03.23", "03.24", "04.01"];
    var name = ["お弁当", "家電製品購入", "ゲーム機"];
    var price = ["¥620", "¥2,300,000", "¥48,000"];

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

    //右から左へスワイプ出来るようになる。
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      // スワイプ後に実行される（削除処理などを書く）
      print('onDismissed');
    },

    // 一行ずつリスト表示
    // flexで横の割合を当てる https://qiita.com/kalupas226/items/5aa41ca409730606000f
    // Containerで各項目の設定をする https://mcommit.hatenadiary.com/entry/2020/01/07/003553

    child: Card(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              date,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                icon,
                style: TextStyle(fontSize: 20),
              )),
        ),
        Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                name,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
              )),
        ),
        Expanded(
          flex: 2,
          child: Container(
              child: Text(
            price,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.right,
          )),
        ),
      ],
    )),
  );
}
