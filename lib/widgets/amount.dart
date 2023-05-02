import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  const Amount({super.key, required this.e});
  // ignore: prefer_typing_uninitialized_variables
  final e;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        '₹${e.amount.toStringAsFixed(2)}',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
            fontSize: 18),
      ),
    );
  }
}
