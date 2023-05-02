import 'package:flutter/material.dart';

import 'amount.dart';

class AmountContainer extends StatelessWidget {
  const AmountContainer({
    super.key,
    required this.appbar,
    required this.eamount,
  });

  final AppBar appbar;
  // ignore: prefer_typing_uninitialized_variables
  final eamount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.07,
      width: (MediaQuery.of(context).size.width) * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
      ),
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Amount(
        e: eamount,
      ),
    );
  }
}
