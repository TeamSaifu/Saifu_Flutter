import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:saifu/shortcut_model.dart';
import 'package:saifu/model/log.dart';
import 'package:saifu/model/budget.dart';
import 'package:saifu/db/log_repository.dart';
import 'package:saifu/db/budget_repository.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  // 三桁ごとにカンマを入れるフォーマット
  final formatter = NumberFormat("#,###");

  DateTime now = DateTime.now();
  int get lastMonthDayNum => DateTime(now.year, now.month + 1, 0).day;

  // 現在の年月日と年月
  static String _nowDate;
  static String _nowMonth;

  // 表示リスト
  List<String> _titleList = [];
  // 表示リストのインデックス
  int _displayIndex = 0;

  double _percent = 0;

  List<PayLog> _logList;
  List<Budget> _budgetList;
  List<PayLog> _todayLogList;

  Future _initLoadData() async {
    _logList = await LogRepository.getAll();
    _budgetList = await BudgetRepository.getAll();
    _todayLogList = await LogRepository.getToday();
  }

  //アプリ起動時に一度だけ実行される
  @override
  void initState() {
    super.initState();
    
    // 日付を取得し表示リストを初期化
    initializeDateFormatting('ja');
    setState(() {
      _nowDate = new DateFormat.yMMMd('ja').format(now).toString();
      _nowMonth = new DateFormat.yMMM('ja').format(now).toString();
      _titleList.addAll([
        '$_nowDate',
        '$_nowDateの予算',
        '$_nowDateまでの予算',
        '$_nowMonthの予算',
      ]);
    });
  }

  // ショートカットリスト
  List<ShortcutItemModel> _shortcutList = [
    ShortcutItemModel(name: '弁当', price: 550),
    ShortcutItemModel(name: '美容院', price: 2800),
    ShortcutItemModel(name: '課金', price: 10000),
    ShortcutItemModel(name: 'うまい棒', price: 10),
    ShortcutItemModel(price: 500),
    ShortcutItemModel(name: '弁当', price: 550),
    ShortcutItemModel(name: '美容院', price: 2800),
    ShortcutItemModel(name: '課金', price: 10000),
    ShortcutItemModel(name: 'うまい棒', price: 10),
  ];

  // ショートカットボタンのページコントローラー
  final PageController controller = PageController(initialPage: 0);

  // テキストWidget
  Widget _textLabel({
    double contentWidth,                      // ラベル幅
    String text,                              // テキスト
    double fontSize = 25.0,                   // フォントサイズ（デフォルト：25）
    Color color = Colors.black,               // テキストカラー（デフォルト：黒）
    TextAlign textAlign = TextAlign.center,   // テキストの位置（デフォルト：中央）
  }) {
    return SizedBox(
      width: contentWidth,
      child: Text(
        '$text',
        style: TextStyle(
          height: 1,
          fontSize: fontSize,
          color: color,
        ),
        textAlign: textAlign,
      ),
    );
  }

  // ショートカットボタンWidget
  Widget _shortcutButton({
    double contentWidth,    // ボタン幅
    double contentHeight,   // ボタン高さ
    int index,              // ショートカットリストのインデックス
  }) {
    return SizedBox(
      width: contentWidth,
      height: contentHeight,

      child: _shortcutList.length > index ? OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textLabel(contentWidth: contentWidth, text: _shortcutList[index].name != null ? _shortcutList[index].name : '', fontSize: 20.0, color: Colors.grey.shade700),
            _textLabel(contentWidth: contentWidth, text: '￥' + formatter.format(_shortcutList[index].price), fontSize: 20.0, color: Colors.grey.shade700),
          ],
        ),
        onPressed: () {

        },
      ) : Container(),
    );
  }

  // ショートカットボタンのページWidget
  Widget _shortcutItems({
    double contentWidth,    // ページ幅
    double contentHeight,   // ページ高さ
    int pageIndex,          // ページインデックス
  }) {
    int index = pageIndex * 4;

    return SizedBox(
      height: contentHeight * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: contentWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index
                ),
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 1
                ),
              ],
            ),
          ),
          SizedBox(
            width: contentWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 2
                ),
                _shortcutButton(
                    contentWidth: contentWidth * 0.48,
                    contentHeight: contentHeight * 0.46,
                    index: index + 3
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;     // 画面幅
    double screenHeight = MediaQuery.of(context).size.height;   // 画面高さ

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
        // 表示部分
        FutureBuilder(
          future: _initLoadData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              int displaytext1;
              int displaytext2;
              int spendDay = 0;
              int spendMonth = 0;
              int budget = 0;

              if (_logList != null && _budgetList != null && _todayLogList != null) {
                _logList.forEach((element) {
                  spendMonth += element.price * element.sign;
                });
                _budgetList.forEach((element) {
                  budget += element.price * element.sign;
                });
                _todayLogList.forEach((element) {
                  spendDay += element.price * element.sign;
                });
                switch(_displayIndex){
                  case 0:
                    displaytext1 = spendMonth;
                    break;
                  case 1:
                    displaytext1 = spendDay;
                    displaytext2 = (budget / lastMonthDayNum).floor();
                    break;
                  case 2:
                    displaytext1 = spendMonth;
                    displaytext2 = ((budget / lastMonthDayNum) * now.day).floor();
                    break;
                  case 3:
                    displaytext1 = spendMonth;
                    displaytext2 = budget;
                    break;
                }
                displaytext2 == null ? _percent = 0 : _percent = displaytext1 * -1 / displaytext2;
              }
              return GestureDetector (
                // 子WidgetにTap処理を付ける
                onTap: () {
                  setState(() {
                    if(_displayIndex == 3) {
                      _displayIndex = 0;
                    } else {
                      _displayIndex += 1;
                    }
                  });
                },
                child: SizedBox(
                  height: screenHeight * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textLabel(
                        contentWidth: screenWidth * 0.8,
                        text: _titleList[_displayIndex],
                        color: Colors.grey.shade600
                      ),
                      _textLabel(
                        contentWidth: screenWidth * 0.8,
                        text: displaytext1 != null ? '￥' + formatter.format(displaytext1 * -1) : '￥0',
                        fontSize: 45.0,
                        color: Colors.cyan
                      ),
                      displaytext2 == null ? Container() : _textLabel(
                        contentWidth: screenWidth * 0.8,
                        text: '/￥' + formatter.format(displaytext2),
                        color: Colors.cyan,
                        textAlign: TextAlign.right
                      ),
                      // 割合ゲージ
                      SizedBox(
                        width: screenWidth * 0.8,

                        child: LinearPercentIndicator(
                          animation: true,                              // アニメーション
                          animationDuration: 500,                       // アニメーションの速さ
                          lineHeight: screenHeight * 0.03,              // ゲージの高さ
                          percent: _percent > 1 ? 1.0 : _percent,                                 // 割合
                          linearStrokeCap: LinearStrokeCap.roundAll,    // ゲージの角の丸み
                          progressColor: _percent > 1 ? Colors.redAccent : Colors.cyan,                   // ゲージの色
                        ),
                      ),
                    ],
                  )
                )
              );
            }
          },
        ),

        // データ入力ボタン
        SizedBox(
          width: screenWidth * 0.8,
          // ショートカットが存在しなければ高さを広げる
          height: _shortcutList.length == 0 ? screenHeight * 0.45 : screenHeight * 0.2,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan,
              onPrimary: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            child: const Icon(Icons.edit, size: 130.0,),

            onPressed: () async {
              final result = await Navigator.of(context).pushNamed('/enter');
              if (result != null) {
                setState(() {
                  _shortcutList.add(result);
                });
              }
            },
          ),
        ),

        // ショートカットボタンのページ
        // ショートカットが存在するときのみ表示
        _shortcutList.length == 0 ? Container() : SizedBox(
          height: screenHeight * 0.25,

          child: PageView.builder(
            controller: controller,
            itemCount: (_shortcutList.length / 4).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return _shortcutItems(contentWidth: screenWidth * 0.8, contentHeight: screenHeight * 0.25, pageIndex: index);
            },
          ),
        ),

        // ショートカットボタンのページインジケータ
        // ショートカットが存在し2ページ以上あるときのみ表示
        _shortcutList.length == 0 || (_shortcutList.length / 4).ceil() == 1 ? Container(height: screenHeight * 0.02,) : SmoothPageIndicator(
          controller: controller,
          count: (_shortcutList.length / 4).ceil(),
          effect: SlideEffect(
            activeDotColor: Colors.cyan,
            dotWidth:  screenHeight * 0.02,
            dotHeight:  screenHeight * 0.02,
          ),
        ),
      ],
    );
  }
}
