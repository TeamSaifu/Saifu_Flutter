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
            // リスト内のアイテムWidgetを呼び出す
            WishListItem(item: 'サメマゲドン', price: '３，３００'),
            WishListItem(item: '単位', price: '１，０００'),
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

// 欲しい物リストのアイテム
class WishListItem extends StatelessWidget {
  // item : 欲しいアイテム
  // price : 値段
  final String item;
  final String price;

  WishListItem({@required this.item, @required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            // 要素の幅を確認するための背景色
            // color: Colors.blue,
            height: 50,
            child:Center(
              child: Text(item),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            // 要素の幅を確認するための背景色
            // color: Colors.red,
            height: 50,
            child:Center(
              child: Text('￥' + price),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            // SizedBoxでボタンのサイズを指定
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // ボタンの背景色を透明化
                primary: Colors.red.withOpacity(0.0),
                shadowColor: Colors.red.withOpacity(0.0),
              ),
              child: Icon(Icons.arrow_drop_down, color: Colors.black),
              onPressed: () {
                // ボタンの処理
              },
            ),
          ),
        ),
      ],
    );
  }
}