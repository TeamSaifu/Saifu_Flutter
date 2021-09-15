import 'package:flutter/material.dart';

import 'package:saifu/db/log_repository.dart';

import 'package:intl/intl.dart';

/*
このページの未実装項目
- or +アイコンを押すと支出と収入が切り替わる
日付を押すとカレンダーが出て支払日を選択できる
カテゴリーを押すとカテゴリー一覧が出てカテゴリーを選択できる
メモの追加
画像選択
写真を撮ってその画像を使用
ショートカットに登録できる
 */

class EnterDataPage extends StatefulWidget {
  EnterDataPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EnterDataState createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterDataPage> {
  int sign = -1;
  DateTime payDay = DateTime.now();
  int category = 0;
  String name = '';
  String picture = '';
  int splitCount = 1;

  TextEditingController _priceInputController;

  void initState() {
    super.initState();
    _priceInputController = TextEditingController();
  }

  void dispose() {
    super.dispose();
    _priceInputController.dispose();
  }

  void _changePayDay({int days, int sign, bool today}) {
    setState(() {
      if (today) {
        payDay = DateTime.now();
      } else {
        payDay = payDay.add(Duration(days: days) * sign);
      }
    });
  }

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
    Function function
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
            if (function != null) function();
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
              if (_priceInputController.text.length > 0) {
                LogRepository.create(
                  price: int.parse(_priceInputController.text),
                  sign: sign,
                  payDay: payDay,
                  name: name,
                  category: category,
                  picture: picture,
                  splitCount: splitCount
                );
                _priceInputController.clear();
                Navigator.of(context).pop();
              }
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
                  sign == -1 ? Icon(Icons.remove, color: Colors.redAccent, size: 40.0) :
                    Icon(Icons.add, color: Colors.blueAccent, size: 40.0),

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
                      controller: _priceInputController,
                      keyboardType: TextInputType.number,
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
                DateFormat('yyy/MM/dd').format(payDay),
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
                  _textButton(
                    contentWidth: screenWidth * 0.8,
                    num: 5,
                    padding: 0.1,
                    text: '-7',
                    fontSize: 17,
                    function: () => _changePayDay(days: 7, sign: -1, today: false)
                  ),
                  _textButton(
                    contentWidth: screenWidth * 0.8,
                    num: 5,
                    padding: 0.1,
                    text: '-1',
                    fontSize: 17,
                    function: () => _changePayDay(days: 1, sign: -1, today: false)
                  ),
                  _textButton(
                    contentWidth: screenWidth * 0.8,
                    num: 5,
                    padding: 0.1,
                    text: '今日',
                    fontSize: 13,
                    function: () => _changePayDay(today: true)
                  ),
                  _textButton(
                    contentWidth: screenWidth * 0.8,
                    num: 5,
                    padding: 0.1,
                    text: '+1',
                    fontSize: 17,
                    function: () => _changePayDay(days: 1, sign: 1, today: false)
                  ),
                  _textButton(
                    contentWidth: screenWidth * 0.8,
                    num: 5,
                    padding: 0.1,
                    text: '+7',
                    fontSize: 17,
                    function: () => _changePayDay(days: 7, sign: 1, today: false)
                  ),
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
