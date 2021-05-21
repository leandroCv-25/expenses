import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  BarChart(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:((context,constraint){
      return Column(
      children: <Widget>[
        Container(
          height: constraint.maxHeight*0.15,
          child: FittedBox(
            child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
          ),
        ),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.6,
          width: 15,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.15,
          child: FittedBox(child: Text(label))),
      ],
    );
    }));
  }
}
