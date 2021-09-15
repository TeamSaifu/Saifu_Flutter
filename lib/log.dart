import 'package:flutter/material.dart';

import 'package:saifu/db/log_repository.dart';
import 'package:saifu/model/log.dart';

import 'package:intl/intl.dart';

class Log extends StatelessWidget {
  final Color pannelColor;
  final String title;

  Log({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      //右上デバッグを消すやつ
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: LogRepository.getAll(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<PayLog> logList = snapshot.data;
              return ListView.builder(
                itemCount: logList != null ? logList.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return _logItem(logList[index], index);
                }
              );
            }
          },
        ),
      )
    );
  }
}

Widget _logItem(PayLog log, int index) {
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
                DateFormat('MM/dd').format(log.payDate),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                log.picture,
                style: TextStyle(fontSize: 20),
              )
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                log.name,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
              )
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
                log.price.toString(),
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
              )
            ),
          ),
        ],
      )
    ),
  );
}
