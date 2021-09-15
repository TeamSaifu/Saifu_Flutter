import 'package:flutter/material.dart';

import 'package:saifu/add_wish_item.dart';
import 'package:saifu/db/wish_item_repository.dart';
import 'package:saifu/model/wish_item.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final formatter = NumberFormat("#,###");

  bool _reload = false;

  _refresh(bool result) {
    setState(() {
      _reload = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: WishItemRepository.getAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<WishItem> _wishItemList = snapshot.data;
            return ListView.builder(
              itemCount: _wishItemList != null ? _wishItemList.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return WishListItem(wishItem: _wishItemList[index], notifyParent: _refresh);
              },
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/add');
          if (result != null) {
            setState(() {
              _reload = result;
            });
          }
        },
      ),
    );
  }
}

// 欲しい物リストのアイテム
class WishListItem extends StatefulWidget {
  WishListItem({Key key, @required this.wishItem, @required this.notifyParent}) : super(key: key);

  final WishItem wishItem;
  final Function(bool) notifyParent;

  @override
  _WishListItemState createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  final formatter = NumberFormat("#,###");

  bool _appearButtons = false;

  void _launchURL({String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  void _editWishItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>AddWishItemPage(
        title: "編集",
        wishItem: widget.wishItem,
      ))
    );
    if (result != null) {
      widget.notifyParent(result);
    }

  }

  Widget _functionButton({@required IconData icon, @required Function function}) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red.withOpacity(0.0),
          shadowColor: Colors.red.withOpacity(0.0),
        ),
        child: Icon(icon, color: Colors.grey.shade600, size: 30,),
        onPressed: () {
          function();
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
                  widget.wishItem.name,
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
                  '￥' + formatter.format(widget.wishItem.price),
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
              _functionButton(icon: Icons.language, function: () => _launchURL(url: widget.wishItem.url)),
              _functionButton(icon: Icons.add_shopping_cart, function: () => {}),
              _functionButton(icon: Icons.create_sharp, function: () => _editWishItem()),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
