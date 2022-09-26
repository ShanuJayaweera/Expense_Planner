import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.parse('0000-00-00');

  void _submitData(){
    String title = titleController.text;
    if (amountController.text.toString().isEmpty){
      return;
    }
    double amount = double.parse(amountController.text);

    if(title.isEmpty || amount <= 0 || _selectedDate == DateTime.parse('0000-00-00')){
      return;
    }

    widget.addTransaction(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),).then((pickedDate) {
          if (pickedDate == null){
            return;
          }
          setState((){
            _selectedDate = pickedDate;
          });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Text'),
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              child: Row( children: <Widget>[
                Text(_selectedDate == DateTime.parse('0000-00-00') ? "No Date Choosen" : DateFormat.yMd().format(_selectedDate) ),
                FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                      ),)
                ),
              ],),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.purple,
              onPressed: _submitData,
              child: Text("Add Transaction"),
            )
          ],),
      ),
    );
  }
}
