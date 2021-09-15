import 'package:flutter/material.dart';

import 'package:saifu/db/wish_item_repository.dart';
import 'package:saifu/model/wish_item.dart';

/*
このページの未実装項目
写真ボタンを押してライブラリから画像を選択できる
 */

class AddWishItemPage extends StatefulWidget {
  AddWishItemPage({Key key, this.title, this.wishItem}) : super(key: key);

  final String title;
  final WishItem wishItem;

  @override
  _AddWishItemState createState() => _AddWishItemState();
}

class _AddWishItemState extends State<AddWishItemPage> {
  // テキストフィールドのコントローラー宣言
  TextEditingController _wishItemInputController;
  TextEditingController _wishItemPriceInputController;
  TextEditingController _wishItemURLInputController;

  // コントローラーの初期化
  void initState() {
    super.initState();
    if (widget.wishItem == null) {
      _wishItemInputController = TextEditingController();
      _wishItemPriceInputController = TextEditingController();
      _wishItemURLInputController = TextEditingController();
    } else {
      _wishItemInputController = widget.wishItem.name == null?
      TextEditingController() : TextEditingController(text: widget.wishItem.name);
      _wishItemPriceInputController = widget.wishItem.price == null?
      TextEditingController() : TextEditingController(text: widget.wishItem.price.toString());
      _wishItemURLInputController = widget.wishItem.url == null?
      TextEditingController() : TextEditingController(text: widget.wishItem.url);
    }
  }

  // statefulオブジェクトが削除されるときに、参照を削除してくれる
  void dispose() {
    super.dispose();
    _wishItemInputController.dispose();
    _wishItemPriceInputController.dispose();
    _wishItemURLInputController.dispose();
  }

  void _insertWishItem() {
    if (_wishItemInputController.text.length > 0) {
      if (widget.wishItem == null) {
        WishItemRepository.create(
          price: int.parse(_wishItemPriceInputController.text),
          name: _wishItemInputController.text,
          url: _wishItemURLInputController.text,
          picture: '',
        );
      } else {
        WishItemRepository.update(
          id: widget.wishItem.id,
          price: int.parse(_wishItemPriceInputController.text),
          name: _wishItemInputController.text,
          url: _wishItemURLInputController.text,
          picture: '',
        );
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // キーボードが出たときにレイアウトが動かないようにするやつ
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title == null ? '新規登録' : widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _insertWishItem,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: ConstrainedBox(
                //　横幅は最大 300px までしか自由に伸長できない制限をかける
                constraints: BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: screenWidth * 0.7,
                  child: TextField(
                    controller: _wishItemInputController,
                    decoration: InputDecoration(
                      labelText: '名称',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: screenWidth * 0.7,
                  child: TextField(
                    controller: _wishItemPriceInputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '値段',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: screenWidth * 0.7,
                  child: TextField(
                    controller: _wishItemURLInputController,
                    decoration: InputDecoration(
                      labelText: 'URL',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: SizedBox(
                  width: screenWidth * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                      onPrimary: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.photo),
                        Text('写真'),
                      ],
                    ),
                    onPressed: () {
                      // ボタンの処理
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
