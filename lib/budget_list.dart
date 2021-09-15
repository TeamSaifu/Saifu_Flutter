import 'package:flutter/material.dart';

import 'package:saifu/add_budget.dart';
import 'package:saifu/db/budget_repository.dart';
import 'package:saifu/model/budget.dart';

import 'package:intl/intl.dart';

class BudgetListPage extends StatefulWidget {
  BudgetListPage({Key key, @required this.title, @required this.sign}) : super(key: key);

  final String title;
  final int sign;

  @override
  _BudgetListPageState createState() => _BudgetListPageState();
}

class _BudgetListPageState extends State<BudgetListPage> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: BudgetRepository.getWhereSign(sign: widget.sign),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Budget> _budgetList = snapshot.data;
              return ListView.builder(
                itemCount: _budgetList != null ? _budgetList.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return BudgetListItem(budget: _budgetList[index]);
                },
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>AddBudgetPage(
                title: widget.sign == 1 ? "新規固定収入" : "新規固定支出",
                sign: widget.sign,
              ))
          );
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

class BudgetListItem extends StatefulWidget {
  BudgetListItem({Key key, @required this.budget}) : super(key: key);

  final Budget budget;

  @override
  _BudgetListItemState createState() => _BudgetListItemState();
}

class _BudgetListItemState extends State<BudgetListItem> {
  final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: const Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              widget.budget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 20.0
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '￥' + formatter.format(widget.budget.price),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 22.0
              ),
            ),
          ),
        ],
      ),
    );
  }
}
