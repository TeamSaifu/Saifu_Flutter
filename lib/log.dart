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
      "メッセージ",
      "メッセージ",
      "メッセージ",
      "メッセージ",
      "メッセージ",
    ];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index >= list.length) {
              list.addAll([
                "メッセージ",
                "メッセージ",
                "メッセージ",
                "メッセージ",
              ]);
            }
            return _messageItem(list[index]);
          },
        )));
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
// @override
// Widget build(BuildContext context) {
//   var list = [
//     "要素1",
//     "要素2",
//     "要素3",
//     "要素4",
//     "要素5",
//   ];
//   final titleTextStyle = Theme.of(context).textTheme.headline6;
//   return Container(
//     child: Center(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Center(
//           child: Text(
//             "リスト表示",
//             style: TextStyle(
//               fontSize: titleTextStyle.fontSize,
//               color: titleTextStyle.color,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
