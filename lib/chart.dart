import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showmodalbottomsheet/provider_tran/transuction_data.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transProvider = Provider.of<TransactionData>(context);
    return Card(
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: transProvider.groupedTransactionValues.map((e) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                (e['day'] as String),
                (e['amount'] as double),
                transProvider.totalSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / transProvider.totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
