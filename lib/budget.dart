import 'package:flutter/material.dart';

import 'package:saifu/budget_list.dart';
import 'package:saifu/db/budget_repository.dart';
import 'package:saifu/model/budget.dart';

import 'package:intl/intl.dart';

class BudgetPage extends StatefulWidget {
  BudgetPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final formatter = NumberFormat("#,###");

  int _income = 0;
  int _outcome = 0;
  int _sumBudget = 0;

  Widget _budgetContainer({
    String title,
    Color color,
    int price,
    Size screenSize,
    bool flg,
    int sign
  }) {
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
                child: FutureBuilder(
                    future: sign != null ? BudgetRepository.getWhereSign(sign: sign) : BudgetRepository.getAll(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Budget> _budgetList = snapshot.data;
                        if (_budgetList != null) {
                          _sumBudget = 0;
                          _income = 0;
                          _outcome = 0;
                          _budgetList.forEach((Budget budget) {
                            if (sign != null) {
                              sign == 1 ? _income += budget.price : _outcome += budget.price;
                            } else {
                              _sumBudget += budget.price * budget.sign;
                            }
                          });
                        }
                        if (sign == null) {
                          return Text(
                            '￥' + formatter.format(_sumBudget),
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.grey.shade700,
                            ),
                          );
                        } else if (sign == 1) {
                          return Text(
                            '￥' + formatter.format(_income),
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.grey.shade700,
                            ),
                          );
                        }
                        return Text(
                          '￥' + formatter.format(_outcome),
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.grey.shade700,
                          ),
                        );
                      }
                    }
                ),
              ),
              flg ? _editButton(screenSize: screenSize, sign: sign) : Container()
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _editButton({Size screenSize, int sign}) {
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
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>BudgetListPage(
                  title: sign == 1 ? "固定収入" : "固定支出",
                  sign: sign,
                ))
            );
            // if (result != null) {
            //   setState(() {
            //     sign == 1 ? _income = result : _outcome = result;
            //   });
            // }
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('予算設定画面'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _budgetContainer(
              title: '予算', color: Colors.lightGreen, price: _income - _outcome, screenSize: _screenSize, flg: false),
          _budgetContainer(
              title: '総収入', color: Colors.blueAccent, price: _income, screenSize: _screenSize, flg: true, sign: 1),
          _budgetContainer(
              title: '総支出', color: Colors.redAccent, price: _outcome, screenSize: _screenSize, flg: true, sign: -1),
        ],
      ),
    );
  }
}
