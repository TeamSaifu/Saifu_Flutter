import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  Widget _budgetContainer({String title, Color color, String price, Size screenSize, bool flg}) {
    Widget _editButton() {
      return SizedBox(
        width: screenSize.width * 0.2,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.cyan,
            onPrimary: Colors.white,
          ),
          child: Text(
            '編集',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            // ボタンの処理
          },
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 34,
              color: color,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  '$price',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              flg ? _editButton() : Container()
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text('予算設定画面'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _budgetContainer(
              '予算', Colors.lightGreen, '46,000円', _screenSize, false),
          _budgetContainer(
              '総収入', Colors.blueAccent, '50,000円', _screenSize, true),
          _budgetContainer(
              '総支出', Colors.redAccent, '4,000円', _screenSize, true),
        ],
      ),
    );
  }
}
