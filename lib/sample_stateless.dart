import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget {
  // 変数
  final Color textColor = Colors.white;
  final String title = 'Hello';

  @override
  Widget build(BuildContext context) {
    return Container(
      // Widgetを縦並びにする
      child: Column(
        children: [
          // Expanded : Widgetの比率（flex）を設定
          Expanded(
            flex: 2,

            // Widgetサイズの設定
            child: SizedBox(
              // double.infinity : 親Widgetのサイズになる
              height: double.infinity,
              width: double.infinity,

              // 子要素を中央に寄せる
              child: Center(
                // ラベル
                child: Text(
                  '$title',

                  // テキストの設定
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30.0
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 1,

            child: Row(
              children: [
                Expanded(
                  flex: 1,

                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,

                    // ボタン
                    child: ElevatedButton(
                      // ボタン設定
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,    // ボタン色
                        onPrimary: textColor,   // 文字、アイコン色
                      ),

                      // ボタンのテキスト
                      child: Text('Button A'),

                      // ボタン処理
                      onPressed: () {

                      },
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,

                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        onPrimary: textColor,
                      ),
                      child: Text('Button B'),
                      onPressed: () {

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
