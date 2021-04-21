import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  // サンプル　State変数
  int _sample_count = 0;

  // サンプル　State変数を更新する関数
  void _sample_method(int index) {
    setState(() {
      _sample_count += index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue, // 要素の幅を確認するための背景色
              child: Text('sample text'),
            ),
            Container(
              child: Text('sample text'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            // ボタンの処理
        },
      ),
    );
  }
}