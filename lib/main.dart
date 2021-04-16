import 'package:flutter/material.dart';

import 'page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pageList = [
    CustomPage(pannelColor: Colors.cyan, title: 'ホーム'),
    CustomPage(pannelColor: Colors.cyan, title: '欲しい物リスト'),
    CustomPage(pannelColor: Colors.cyan, title: '履歴'),
    CustomPage(pannelColor: Colors.cyan, title: '設定'),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        title: _pageTitle[_selectedIndex],
      ),
      body: _pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
