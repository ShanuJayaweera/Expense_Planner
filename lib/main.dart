import 'dart:ffi';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
        )),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold
            ))),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  bool _showChart = false;

  final List<Transaction> _userTransactions = [
    Transaction(id: "t1", title: "Red Pants", amount: 250.00, date: DateTime.now()),
    Transaction(id: "t2", title: "Shoe", amount: 23400.99, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),),);
    }).toList();
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
    });
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text("Show Chart"),
                Switch(value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                })
              ],
            ),

            _showChart ? Container(
              height: (MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top)) * 0.3,
              width: double.infinity,
              child: Chart(_recentTransactions),
            ) :

            Container(
              height: (MediaQuery.of(context).size.height - (appBar.preferredSize.height + MediaQuery.of(context).padding.top)) * 0.7,
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
