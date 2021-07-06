import 'package:flutter/material.dart';

class EnterDataPage extends StatefulWidget {
  EnterDataPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EnterDataState createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterDataPage> {
  // 区切り線
  Widget _divider({double padding = 0.0}) {
    return Divider(
      // 線の上下の余白
      height: padding,
      // 線の太さ
      thickness: 3,
      color: Colors.cyan,
      // 前の余白
      indent: 0,
      // 後ろの余白
      endIndent: 0,
    );
  }

  Widget _textButton({
    double contentWidth,
    int num = 1,
    double padding = 0.0,
    String text,
    double fontSize = 20,
  }) {
    var buttonWidth = contentWidth / num * (1 - padding);
    var paddingWidth = contentWidth / num * padding / 2;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingWidth),

      child: SizedBox(
        width: buttonWidth,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.cyan,
            onPrimary: Colors.white,
          ),

          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),

          // ボタン処理
          onPressed: () {

          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // キーボードが出たときにレイアウトが動かないようにするやつ
      resizeToAvoidBottomInset: false,

      // アプリバー
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),

        title: Text('データ入力'),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // ボタン処理
            },
          ),
        ],
      ),


      // 本体
      body: Container(
        child: Column(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    Icons.remove,
                    color: Colors.redAccent,
                    size: 40.0,
                  ),

                  Text(
                    '￥',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 40.0
                    ),
                  ),

                  SizedBox(
                    width: screenWidth * 0.5,

                    child: TextField(
                      maxLength: 9,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.cyan,
                        height: 1.4,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _divider(),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),

              child: Text(
                '2021/05/01(今日)',
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 40.0
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  _textButton(contentWidth: screenWidth * 0.8, num: 5, padding: 0.1, text: '-7', fontSize: 17),
                  _textButton(contentWidth: screenWidth * 0.8, num: 5, padding: 0.1, text: '-1', fontSize: 17),
                  _textButton(contentWidth: screenWidth * 0.8, num: 5, padding: 0.1, text: '今日', fontSize: 13),
                  _textButton(contentWidth: screenWidth * 0.8, num: 5, padding: 0.1, text: '+1', fontSize: 17),
                  _textButton(contentWidth: screenWidth * 0.8, num: 5, padding: 0.1, text: '+7', fontSize: 17),
                ],
              ),
            ),

            // Container( child: _divider() ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: _textButton(contentWidth: screenWidth * 0.8, text: 'カテゴリーを選択'),
              // child: _largeButton(screenWidth, 'カテゴリーを選択'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: _textButton(contentWidth: screenWidth * 0.8, text: 'メモを追加'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textButton(contentWidth: screenWidth * 0.63, text: '画像の追加'),
                  Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, 0, 0),

                      child: SizedBox(
                        width: screenWidth * 0.15,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                            onPrimary: Colors.white,
                          ),

                          child: Icon(Icons.camera_alt),

                          // ボタン処理
                          onPressed: () {

                          },
                        ),
                      )
                  ),
                ],
              ),
              // child: _textButton(contentWidth: screenWidth * 0.8, text: '画像の追加'),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: _textButton(contentWidth: screenWidth * 0.8, text: 'ショートカットに登録'),
            ),
          ],
        ),
      ),
    );
  }
}
