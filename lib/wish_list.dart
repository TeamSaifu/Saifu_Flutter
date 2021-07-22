import 'package:flutter/material.dart';

import 'package:saifu/wish_item_model.dart';

import 'package:intl/intl.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final formatter = NumberFormat("#,###");

  // WishItemの一覧リスト変数を用意
  List<WishItemModel> wishItemList = [
    WishItemModel(item: 'サメマゲドン', price: 3300),
    WishItemModel(item: '単位', price: 10000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // リストの長さを計算
        itemCount: wishItemList.length,
        itemBuilder: (BuildContext context, int index) {
          return _wishListItem(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // resultにAddWishItemページの入力値が返ってくる
          final result = await Navigator.of(context).pushNamed('/add');
          if (result != null) {
            setState(() {
              wishItemList.add(result);
            });
          }
        },
      ),
    );
  }

  // 欲しい物リストのアイテム
  Widget _wishListItem(index) {
    return Container(
      height: 70,
      // Itemのボーダー線
      decoration: const BoxDecoration(
          border: const Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              wishItemList[index].item,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 20.0
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '￥' + formatter.format(wishItemList[index].price),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 22.0
              ),
            ),
          ),
          SizedBox(
            // SizedBoxでボタンのサイズを指定
            width: 70,
            height: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // ボタンの背景色を透明化
                primary: Colors.red.withOpacity(0.0),
                shadowColor: Colors.red.withOpacity(0.0),
              ),
              child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600, size: 40,),
              onPressed: () {
                // ボタンの処理
              },
            ),
          ),
        ],
      ),
    );
  }
}
