import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  DateTime _dateTransaction;

  void _submitTransaction() {
    String _enteredtitle = _titleController.text;
    double _enteredamount = double.parse(_amountController.text);

    if (_enteredtitle.isEmpty ||
        _enteredamount <= 0 ||
        _dateTransaction == null) {
      return;
    }

    widget._addTransaction(_enteredtitle, _enteredamount, _dateTransaction);
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _dateTransaction = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        color: Colors.blueGrey[50],
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                  controller: _titleController,
                  onSubmitted: (_) {
                    _submitTransaction();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "amount",
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                  controller: _amountController,
                  onSubmitted: (_) {
                    _submitTransaction();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Choose Data",
                        style: Theme.of(context).textTheme.title,
                      ),
                      onPressed: () {
                        _presentDatePicker(context);
                      },
                    ),
                    Text(
                      _dateTransaction == null
                          ? "No Date Choosen"
                          : DateFormat.yMMMd().format(_dateTransaction),
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).textTheme.title.color,
                ),
                onPressed: _submitTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
