import 'package:flutter/material.dart';

class SamplePage extends StatefulWidget {
  SamplePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<SamplePage> {
  // サンプル変数
  int _samplevariable = 0;

  // サンプル関数
  void _sampleMethod() {
    // ↑の変数（State）を更新するためにはsetState()を使って更新する
    setState(() {
      _samplevariable++;
    });
  }

  // ↓デザイン部分
  // よく使うWidget : https://qiita.com/coka__01/items/dedb569f6357f1b503fd
  @override
  Widget build(BuildContext context) {
    // 画面サイズを取得（幅）
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // キーボードが出たときにレイアウトが動かないようにするやつ
      resizeToAvoidBottomInset: false,

      //////////////
      // アプリバー //
      //////////////
      appBar: AppBar(
        // 戻るボタン
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),

        // アプリバーのタイトル
        title: Text('新規登録'),

        // アプリバーの右にボタンやアイコンを設定する
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // ボタン処理
            },
          ),
        ],
      ),

      ///////////////////
      // 本体のレイアウト //
      ///////////////////
      body: Container(
        child: Column(
          // Column、Rowの要素を中央に寄せる
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            // パディングの設定
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),

              // Widgetサイズの設定
              child: SizedBox(
                width: screenWidth * 0.7,

                // テキストボックス
                child: TextField(
                  // テキストボックス設定
                  decoration: InputDecoration(
                    labelText: '名称',
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),

              child: SizedBox(
                width: screenWidth * 0.7,

                // ラベル
                child: Text(
                  '$_samplevariable',

                  // テキストを中央揃え
                  textAlign: TextAlign.center,

                  // テキストの設定
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                width: screenWidth * 0.4,

                // ボタン
                child: ElevatedButton(
                  // ボタン設定
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,     // ボタン色
                    onPrimary: Colors.white,  // 文字、アイコン色
                    shape: StadiumBorder(),   // ボタンの角の形
                  ),

                  // ボタンのアイコン
                  child: Icon(Icons.photo),
                  // その他サンプルボタン
                  // child: Text('写真'), // テキストボタン
                  // child: Row(         // アイコンとテキストのボタン１
                  //   children: [
                  //     Icon(Icons.photo),
                  //     Text('写真'),
                  //   ],
                  // ),
                  // child: Column(      // アイコンとテキストのボタン２
                  //   children: [
                  //     Icon(Icons.photo),
                  //     Text('写真'),
                  //   ],
                  // ),

                  // ボタンの処理（関数呼び出し）
                  onPressed: () => _sampleMethod(),
                  // ボタン処理
                  // onPressed: () {
                  //
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
