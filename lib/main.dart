import 'package:flutter/material.dart';
import 'package:saifu/page.dart';
import 'package:saifu/wish_list.dart';
import 'package:saifu/add_wish_item.dart';
import 'package:saifu/enter_data.dart';
import 'package:saifu/log.dart';
import 'package:saifu/setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //右上デバッグを消すやつ
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ルーティングを記述
      // home: MyHomePage(title: 'Flutter Demo Home Page'), // <- ルーティングを記述したので不要
      initialRoute: '/',
      routes: {
        '/': (_) => MyHomePage(),
        '/add': (_) => AddWishItemPage(),
        '/enter': (_) => EnterDataPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  // ナビゲーションバー
  // https://dev.classmethod.jp/articles/basic_bottom_navigation_flutter/
  @override
  //初期ページ
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  //画面のリストを作成 (ここで切り替え先を指定する）
  static List<Widget> _pageList = [
    CustomPage(pannelColor: Colors.cyan, title: 'ホーム'),
    WishListPage(),
    Log(pannelColor: Colors.cyan, title: '履歴'),
    Setting(pannelColor: Colors.cyan, title: '設定'),
  ];

  // 一番上のタイトルを変えるとこ
  static List<Widget> _pageTitle = [
    Text('ホーム'),
    Text('欲しい物リスト'),
    Text('履歴'),
    Text('設定'),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //本体
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pageTitle[_selectedIndex],
      ),
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // ここを変えたらアイコンとか文字とか変えられる
        // Icon（Icons.***) でいろいろアイコンが出せますよ～
        // https://api.flutter.dev/flutter/material/Icons-class.html
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '欲しい物リスト',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: '履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: '設定',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}
