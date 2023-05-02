import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showmodalbottomsheet/provider_tran/transuction_data.dart';
import 'package:showmodalbottomsheet/title.dart';
import '../widgets/amountcontainer.dart';
import 'chart.dart';
import 'noentry.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  bool isInit = true;
  bool isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((value) =>
    //     Provider.of<TransactionData>(context, listen: false).fetchSetData());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<TransactionData>(context, listen: false)
          .fetchSetData()
          .then((value) => setState(() {
                isLoading = false;
              }));
    }

    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final transProvider = Provider.of<TransactionData>(
      context,
    );
    final appbar = AppBar(
      title: const Center(
          child: Text(
        'Your Expenses',
        style:
            TextStyle(color: Color.fromARGB(255, 254, 255, 255), fontSize: 25),
      )),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () => transProvider.openAddTransactionModal(context),
            icon: const Icon(Icons.add),
          );
        }),
      ],
    );
    return Builder(builder: (context) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        resizeToAvoidBottomInset: false,
        appBar: appbar,
        body: (transProvider.isLoading || isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.2535,
                      child: const Chart()),
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: ListView(
                      children: [
                        transProvider.transuction.isEmpty
                            ? const NoEntry()
                            : Column(
                                children: transProvider.transuction.map((e) {
                                  return Card(
                                    elevation: 8,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AmountContainer(
                                              appbar: appbar,
                                              eamount: e,
                                            ),
                                            Tittle(
                                              appbar: appbar,
                                              e: e,
                                            ),
                                            Container(
                                              width: (MediaQuery.of(context)
                                                      .size
                                                      .width) *
                                                  0.08,
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              child: Consumer<TransactionData>(
                                                builder:
                                                    (context, value, child) =>
                                                        TextButton(
                                                  onPressed: () => value
                                                      .deleteTransactionHandler(
                                                          e.id),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    size: 35,
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 0))
                                                    ],
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: SizedBox(
          height: (MediaQuery.of(context).size.height -
                  appbar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.13,
          child: FloatingActionButton(
            elevation: 4,
            hoverColor: Colors.green,
            onPressed: () => transProvider.openAddTransactionModal(context),
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
