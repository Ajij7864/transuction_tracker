import 'package:flutter/material.dart';

class NoEntry extends StatelessWidget {
  const NoEntry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          child: Text(
            'You don\'t have any Expenses.',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          height: 400,
          width: 300,
          child: const Image(
            image: AssetImage("assets/images/mikasa.jpeg"),
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
