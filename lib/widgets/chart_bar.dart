import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double spendingPtcOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPtcOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint){
      return Column(
        children: <Widget>[
          Container(
            height: constraint.maxHeight * 0.1,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child:Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPtcOfTotal,
                child: Container(decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                ),)
            ],),),
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.08,
            child: FittedBox(child: Text(label),),
          ),

        ],
      );
    });
  }
}
