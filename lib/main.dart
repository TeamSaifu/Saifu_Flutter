import 'package:flutter/material.dart';
import 'dart:io';

import 'package:saifu/add_wish_item.dart';
import 'package:saifu/budget.dart';
import 'package:saifu/enter_data.dart';
import 'package:saifu/log.dart';
import 'package:saifu/shortcut.dart';
import 'package:saifu/wish_list.dart';
import 'package:saifu/setting.dart';
import 'package:saifu/home.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
        '/shortcut': (_) => ShortcutPage(),
        '/budget': (_) => BudgetPage(),
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
  BannerAd _bannerAd;
  bool _isAdLoaded = false;

  int _selectedIndex = 0;

  //画面のリストを作成 (ここで切り替え先を指定する）
  static List<Widget> _pageList = [
    HomePage(),
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

  @override
  void initState(){
    super.initState();

    // 広告の初期化
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid ?
          'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_){
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad,error){
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose(){
    //　広告を削除
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pageTitle[_selectedIndex],
      ),
      body: Column(
        children: [
          Expanded(child: _pageList[_selectedIndex]),
          _isAdLoaded ? Container(
            child: AdWidget(ad: _bannerAd),
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            alignment: Alignment.center,
          ) : Container(),
        ],
      ),

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
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
