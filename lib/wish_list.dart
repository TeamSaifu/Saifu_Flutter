import 'package:flutter/material.dart';
import 'package:saifu/wish_item_model.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  // WishItemの一覧リスト変数を用意
  List<WishItemModel> wishItemList = [
    WishItemModel(item: 'サメマゲドン', price: '3300'),
    WishItemModel(item: '単位', price: '10000'),
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
      // Itemのボーダー線
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              // 要素の幅を確認するための背景色
              // color: Colors.blue,
              margin: EdgeInsets.all(10.0),
              child:Text(
                wishItemList[index].item,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 18.0
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // 要素の幅を確認するための背景色
              // color: Colors.red,
              margin: EdgeInsets.all(10.0),
              child:Text(
                '￥' + wishItemList[index].price,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 18.0
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SizedBox(
                // SizedBoxでボタンのサイズを指定
                height: 60,
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
          ),
        ],
      ),
    );
  }
}
