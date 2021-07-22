import 'package:flutter/material.dart';
import 'package:saifu/wish_item_model.dart';

class AddWishItemPage extends StatefulWidget {
  AddWishItemPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddWishItemState createState() => _AddWishItemState();
}

class _AddWishItemState extends State<AddWishItemPage> {
  // WishItemモデルを用意
  WishItemModel wishItem;

  // テキストフィールドのコントローラー宣言
  TextEditingController _wishItemInputController;
  TextEditingController _wishItemPriceInputController;
  TextEditingController _wishItemURLInputController;

  // コントローラーの初期化
  void initState() {
    super.initState();
    _wishItemInputController = TextEditingController();
    _wishItemPriceInputController = TextEditingController();
    _wishItemURLInputController = TextEditingController();
  }

  // statefulオブジェクトが削除されるときに、参照を削除してくれる
  void dispose() {
    super.dispose();
    _wishItemInputController.dispose();
    _wishItemPriceInputController.dispose();
    _wishItemURLInputController.dispose();
  }

  void _addWishItem() {
    // 入力があるときに実行
    if (_wishItemInputController.text.length > 0) {
      wishItem = WishItemModel(
        item: _wishItemInputController.text,
        price: int.parse(_wishItemPriceInputController.text),
        url: _wishItemURLInputController.text,
      );
      // テキストボックスを初期化
      _wishItemInputController.clear();
      _wishItemPriceInputController.clear();
      _wishItemURLInputController.clear();
      // テキストの内容を渡しつつ画面遷移
      Navigator.of(context).pop(wishItem);
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
        title: Text('新規登録'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _addWishItem,
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
