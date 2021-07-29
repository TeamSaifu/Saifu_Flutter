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
  List<WishItemModel> _wishItemList = [
    WishItemModel(item: 'サメマゲドン', price: 3300),
    WishItemModel(item: '単位', price: 10000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // リストの長さを計算
        itemCount: _wishItemList.length,
        itemBuilder: (BuildContext context, int index) {
          return WishListItem(item: _wishItemList[index].item, price: _wishItemList[index].price);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // resultにAddWishItemページの入力値が返ってくる
          final result = await Navigator.of(context).pushNamed('/add');
          if (result != null) {
            setState(() {
              _wishItemList.add(result);
            });
          }
        },
      ),
    );
  }
}

// 欲しい物リストのアイテム
class WishListItem extends StatefulWidget {
  WishListItem({Key key, @required this.item, @required this.price}) : super(key: key);

  final String item;
  final int price;

  @override
  _WishListItemState createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  final formatter = NumberFormat("#,###");

  bool _appearButtons = false;

  Widget _functionButton({@required IconData icon}) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red.withOpacity(0.0),
          shadowColor: Colors.red.withOpacity(0.0),
        ),
        child: Icon(icon, color: Colors.grey.shade600, size: 40,),
        onPressed: () {

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Itemのボーダー線
      decoration: const BoxDecoration(
          border: const Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.item,
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
                  '￥' + formatter.format(widget.price),
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
                    setState(() {
                      _appearButtons = !_appearButtons;
                    });
                  },
                ),
              ),
            ],
          ),
          _appearButtons? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _functionButton(icon: Icons.home),
              _functionButton(icon: Icons.settings),
              _functionButton(icon: Icons.work),
            ],
          ) : Container(),
        ],
      ),
      // child: Row(
      //   children: [
      //     Expanded(
      //       flex: 3,
      //       child: Text(
      //         widget.item,
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //             color: Colors.grey.shade700,
      //             fontSize: 20.0
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       flex: 2,
      //       child: Text(
      //         '￥' + formatter.format(widget.price),
      //         style: TextStyle(
      //             color: Colors.grey.shade600,
      //             fontSize: 22.0
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       // SizedBoxでボタンのサイズを指定
      //       width: 70,
      //       height: 70,
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           // ボタンの背景色を透明化
      //           primary: Colors.red.withOpacity(0.0),
      //           shadowColor: Colors.red.withOpacity(0.0),
      //         ),
      //         child: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600, size: 40,),
      //         onPressed: () {
      //           setState(() {
      //             _appearButtons = !_appearButtons;
      //           });
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
