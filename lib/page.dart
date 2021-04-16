import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  // 汎用的なページ 下のやつ渡すとなんか出る
  // pannelColor : 画面色
  // title : 真ん中の文字
  final Color pannelColor;
  final String title;

  CustomPage({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headline6;
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: pannelColor,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleTextStyle.fontSize,
                color: titleTextStyle.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
