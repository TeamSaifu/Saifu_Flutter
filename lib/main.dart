import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:saifu/add_wish_item.dart';
import 'package:saifu/log.dart';
import 'package:saifu/page.dart';
import 'package:saifu/wish_list.dart';

// バックグラウンドで通知を使用するやつ
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

// 通知用のチャンネルを作成
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  enableVibration: true,
  playSound: true,
);

// 通知用のパッケージ導入
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //名前付きのトップレベル関数として設定
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //FCMチャンネルをオーバーライドし通知を有効にする
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // iOSのフォアグラウンド通知の表示オプションを更新する
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await DotEnv().load('.env');
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
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.message}) : super(key: key);

  final String title;
  final RemoteMessage message;

  // ナビゲーションバー
  // https://dev.classmethod.jp/articles/basic_bottom_navigation_flutter/
  @override
  //初期ページ
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // 通知のあれこれ
  @override
  void initState() {
    /// iOS用 PUSH通知の許可確認
    _firebaseMessaging.requestPermission();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) async {
      if (message != null) {
        print(message);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(message: message),
          ),
        );
      }
      // Logcatにtoken表示
      String token = await FirebaseMessaging.instance.getToken();
      print("tokena:" + token);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      print(message);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(message: message),
        ),
      );
    });
    super.initState();
  }

//画面のリストを作成 (ここで切り替え先を指定する）
  static List<Widget> _pageList = [
    CustomPage(pannelColor: Colors.cyan, title: 'ホーム'),
    WishListPage(),
    Log(pannelColor: Colors.cyan, title: '履歴'),
    CustomPage(pannelColor: Colors.cyan, title: '設定'),
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
