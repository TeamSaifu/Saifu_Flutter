import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  Widget _budgetContainer({String title, Color color, String price, Size screenSize, bool flg}) {
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
              flg ? _editButton(screenSize: screenSize) : Container()
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _editButton({Size screenSize}) {
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
              title: '予算', color: Colors.lightGreen, price: '46,000円', screenSize: _screenSize, flg: false),
          _budgetContainer(
              title: '総収入', color: Colors.blueAccent, price: '50,000円', screenSize: _screenSize, flg: true),
          _budgetContainer(
              title: '総支出', color: Colors.redAccent, price: '4,000円', screenSize: _screenSize, flg: true),
        ],
      ),
    );
  }
}
