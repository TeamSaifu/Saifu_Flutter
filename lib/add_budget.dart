import 'package:flutter/material.dart';

import 'package:saifu/db/budget_repository.dart';
import 'package:saifu/model/budget.dart';

/*
このページの未実装項目

 */

class AddBudgetPage extends StatefulWidget {
  AddBudgetPage({Key key, @required this.title, this.budget, @required this.sign}) : super(key: key);

  final String title;
  final Budget budget;
  final int sign;

  TextEditingController _budgetNameController;
  TextEditingController _budgetPriceController;

  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudgetPage> {

  TextEditingController _budgetNameController;
  TextEditingController _budgetPriceController;

  void initState() {
    super.initState();
    if (widget.budget == null) {
      _budgetNameController = TextEditingController();
      _budgetPriceController = TextEditingController();
    } else {
      _budgetNameController = widget.budget.name == null?
        TextEditingController() : TextEditingController(text: widget.budget.name);
      _budgetPriceController = widget.budget.price == null?
        TextEditingController() : TextEditingController(text: widget.budget.price.toString());
    }
  }

  void dispose() {
    super.dispose();
    _budgetNameController.dispose();
    _budgetPriceController.dispose();
  }

  void _insertBudget() {
    if (_budgetNameController.text.length > 0) {
      if (widget.budget == null) {
        BudgetRepository.create(
          price: int.parse(_budgetPriceController.text),
          name: _budgetNameController.text,
          sign: widget.sign,
        );
      } else {
        BudgetRepository.update(
          id: widget.budget.id,
          price: int.parse(_budgetPriceController.text),
          name: _budgetNameController.text,
          sign: widget.budget.sign,
        );
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _insertBudget,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                width: _screenSize.width * 0.7,
                child: TextField(
                  controller: _budgetNameController,
                  decoration: InputDecoration(
                    labelText: widget.sign == 1 ? '収入名' : '支出名',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                width: _screenSize.width * 0.7,
                child: TextField(
                  controller: _budgetPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: widget.sign == 1 ? '収入額' : '支出額',
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
