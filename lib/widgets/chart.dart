import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {

  List <Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i<recentTransaction.length; i++){
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year){
          totalSum += recentTransaction[i].amount;

        }
      }
      return {"day": DateFormat.E().format(weekday).substring(0, 1), "amount": totalSum};
    });
  }

  double get _totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Card(

      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.loose,
              child: ChartBar(
                data['day'].toString(),
                data['amount'] as double,
                _totalSpending == 0.0 ? 0.0 : (data['amount'] as double)/_totalSpending,
              ),);

          }).toList(),),
      ),
    );
  }
}
