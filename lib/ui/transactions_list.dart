import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final Function _deleteTransaction;
  TransactionsList(this._transactionsList,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactionsList.isEmpty
        ? LayoutBuilder(builder: (context, constraints){
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: constraints.maxHeight*0.7,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "No Transactions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ); 
        },) 
        : ListView.builder(
            itemCount: _transactionsList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${_transactionsList[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactionsList[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactionsList[index].date),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  trailing: MediaQuery.of(context).size.width>450?
                  FlatButton.icon(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    label: Text("Delete"),
                    textTheme: Theme.of(context).buttonTheme.textTheme,
                    onPressed: (){
                      _deleteTransaction(_transactionsList[index].id);
                    },
                  )
                  :IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: (){
                      _deleteTransaction(_transactionsList[index].id);
                    },
                  ),
                ),
              );
            },
          );
  }
}
