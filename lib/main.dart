import 'package:flutter/material.dart';

import './models/transactions.dart';

import './ui/transactions_list.dart';
import './ui/new_transaction.dart';
import './ui/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Manager',
      theme: ThemeData(
          fontFamily: "Quicksand",
          primarySwatch: Colors.amber,
          secondaryHeaderColor: Colors.lightBlue,
          primaryColor: Colors.amber,
          accentColor: Colors.grey,
          textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              subtitle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 40,
                      color: Colors.blueGrey)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 50.5,
        title: "Books"),
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 50.5,
        title: "Books"),
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 50.5,
        title: "Books"),
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 50.5,
        title: "Books"),
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 50.5,
        title: "Books"),
    Transaction(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        amount: 1500,
        title: "Car"),
  ];

  bool _showChart = false;

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _addTransaction(String title, double amount, DateTime date) {
    Transaction tx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _transactions.add(tx);
    });

    Navigator.of(context).pop();
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        "Expenses",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if(_isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart", style: Theme.of(context).textTheme.title),
                Switch(
                  value: _showChart,
                  onChanged: ((val) {
                    setState(() {
                      _showChart = val;
                    });
                  }),
                  activeColor: Colors.amber,
                ),
              ],
            ),
            _isLandscape
                ?_showChart
                    ? _transactions.isEmpty
                        ? Divider(
                            thickness: 1,
                          )
                        : Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.7,
                            child: Chart(_recentTransactions),
                          )
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child:
                            TransactionsList(_transactions, _deleteTransaction),
                      )
                :_transactions.isEmpty
                    ? Divider(
                        thickness: 1,
                      )
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.3,
                        child: Chart(_recentTransactions),
                      ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionsList(_transactions, _deleteTransaction),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.amber,
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
