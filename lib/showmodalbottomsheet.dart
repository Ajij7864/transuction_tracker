import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:showmodalbottomsheet/provider_tran/transuction_data.dart';

class AddTransactionModal extends StatefulWidget {
  const AddTransactionModal({
    super.key,
  });

  @override
  State<AddTransactionModal> createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: Card(
          elevation: 15,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 4,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Consumer<TransactionData>(
                  builder: (context, value, child) => TextField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    controller: value.amountController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Consumer<TransactionData>(
                  builder: (context, value, child) => TextField(
                    controller: value.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<TransactionData>(
                        builder: (context, value, child) => Text(
                          'Chosen Date: ${DateFormat.yMd().format(value.selectedDate)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Consumer<TransactionData>(
                        builder: (context, value, child) => TextButton(
                          onPressed: () => value.showDatePickerHandler(context),
                          child: const Text(
                            'Choose Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<TransactionData>(
                  builder: (context, value, child) => ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 71, 13, 49)),
                    ),
                    onPressed: () => value.addTransactionHandler(context),
                    child: const Text(
                      'Add Transaction',
                      style:
                          TextStyle(color: Color.fromARGB(255, 220, 233, 233)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
