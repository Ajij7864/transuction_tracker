import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:showmodalbottomsheet/transuction_list.dart';

import '../showmodalbottomsheet.dart';

class TransactionData with ChangeNotifier {
  List<Transuctons> _transuction = [];

  List<Transuctons> get transuction => _transuction;

  List<Transuctons> get recentTransaction {
    return transuction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteTransactionHandler(String id) async {
    transuction.removeWhere((element) => element.id == id);
    notifyListeners();

    final url = Uri.parse(
        'https://transuction7864-default-rtdb.firebaseio.com/trans/$id.json');
    await http.delete(url);
  }

  void openAddTransactionModal(BuildContext context) {
    notifyListeners();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const AddTransactionModal();
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  void showDatePickerHandler(BuildContext context) {
    selectedDate = DateTime.now();
    notifyListeners();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate = pickedDate;
      notifyListeners();
    });
  }

  bool isLoading = false;
  bool isColorlight = true;

  void addTransactionHandler(BuildContext context) async {
    final enteredTitle = titleController.text;
    final enteredAmount = int.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      isColorlight = true;
      notifyListeners();
      return;
    } else {
      isColorlight = false;
      notifyListeners();
    }

    isLoading = true;
    try {
      final url = Uri.parse(
          'https://transuction7864-default-rtdb.firebaseio.com/trans.json');
      final response = await http.post(url,
          body: json.encode({
            'title': enteredTitle,
            'amount': enteredAmount,
            'date': selectedDate.toIso8601String(),
          }));

      if (response.statusCode != 200) {
        // handle error
        return;
      }

      final newTransaction = Transuctons(
        id: json.decode(response.body)['name'],
        title: enteredTitle,
        amount: enteredAmount,
        date: selectedDate,
      );

      transuction.add(newTransaction);
      notifyListeners();
      titleController.clear();
      amountController.clear();
      selectedDate = DateTime.now();
      Navigator.of(context).pop();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSetData() async {
    final url = Uri.parse(
        'https://transuction7864-default-rtdb.firebaseio.com/trans.json');
    final response = await http.get(url);
    print(json.decode(response.body));

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Transuctons> loadedTrans = [];
    extractedData.forEach((key, value) {
      loadedTrans.insert(
          0,
          Transuctons(
              id: key,
              amount: value['amount'],
              date: DateTime.parse(
                  value['date'] as String), // convert to DateTime
              title: value['title']));
    });
    _transuction = loadedTrans;
    notifyListeners();
  }

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }
}
