import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tittle extends StatelessWidget {
  const Tittle({super.key, required this.appbar, required this.e});

  final AppBar appbar;
  // ignore: prefer_typing_uninitialized_variables
  final e;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.5,
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.105,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) * 0.5,
            height: 30,
            padding: const EdgeInsets.all(1),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                e.title,
                maxLines: 5,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 20,
            width: (MediaQuery.of(context).size.width) * 0.5,
            padding: const EdgeInsets.only(top: 4, left: 2, right: 2),
            child: FittedBox(
              child: Text(
                DateFormat.yMMMEd().format(e.date),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
