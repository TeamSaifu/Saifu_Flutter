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
    var list = [
      "メッセージ1",
      "メッセージ2",
      "メッセージ3",
      "メッセージ4",
      "メッセージ5",
      "メッセージ6",
      "メッセージ7",
      "メッセージ8",
      "メッセージ9",
      "メッセージ10",
    ];
    return MaterialApp(
      //右上デバッグを消すやつ
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: ListView.builder(
          // listの上限を設定
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return _messageItem(list[index]);
          },
        )));
  }

  Widget _messageItem(String title) {
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
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
    );
  }
}
