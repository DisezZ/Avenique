import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ReportsAccBarStatbox extends StatefulWidget {
  const ReportsAccBarStatbox({super.key});

  @override
  State<ReportsAccBarStatbox> createState() => _ReportsAccBarStatboxState();
}

class _ReportsAccBarStatboxState extends State<ReportsAccBarStatbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 15, 202, 34),
          borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8.0),
              child: Text('Acc Name:', style: TextStyle(fontSize: 18)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 16.0),
              child: Text('THB 300.00', style: TextStyle(fontSize: 16)),
            ),
          ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5, left: 8.0, bottom: 8),
            child: Stack(
              children: [
                Container(
                  height: 22,
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
                Container(
                  height: 22,
                  width: 260,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ],
            )),
      ]),
    );
  }
}

class ReportsAllAccStatBar extends StatefulWidget {
  const ReportsAllAccStatBar({super.key});

  @override
  State<ReportsAllAccStatBar> createState() => _ReportsAllAccStatBarState();
}

class _ReportsAllAccStatBarState extends State<ReportsAllAccStatBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 29, 246, 221),
              borderRadius: BorderRadius.circular(16)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child:
                    Text('Income & Expenses', style: TextStyle(fontSize: 21))),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8))),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 4, left: 10.0),
                child:
                    Text('Range:Last 7 Days', style: TextStyle(fontSize: 14))),
            Padding(
                padding: EdgeInsets.only(bottom: 8, left: 10.0),
                child: Text('THB: 290.00', style: TextStyle(fontSize: 28))),
            IncomeExpensesBox(
              topicName: 'INCOME',
              amount: 'THB 400.00',
            ),
            CategoriesStatBox(
              topicName: 'Income',
              amount: 'THB 400.00',
              color: Colors.black,
            ),
            IncomeExpensesBox(
              topicName: 'EXPENSE',
              amount: 'THB 400.00',
            ),
            CategoriesStatBox(
              topicName: 'Food & Drinks',
              amount: 'THB 400.00',
              color: Colors.black,
            ),
            CategoriesStatBox(
              topicName: 'Shoping',
              amount: 'THB 400.00',
              color: Colors.black,
            ),
            CategoriesStatBox(
              topicName: 'Housing',
              amount: 'THB 400.00',
              color: Colors.black,
            ),
            CategoriesStatBox(
              topicName: 'Transportation',
              amount: 'THB 400.00',
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 246, 221),
                    borderRadius: BorderRadius.circular(16)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class IncomeExpensesBox extends StatefulWidget {
  const IncomeExpensesBox({
    super.key,
    required this.topicName,
    required this.amount,
  });
  final String topicName;
  final String amount;
  //const IncomeExpensesBox({super.key});
  @override
  State<IncomeExpensesBox> createState() => _IncomeExpensesBoxState();
}

class _IncomeExpensesBoxState extends State<IncomeExpensesBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 6, 97, 7),
        // borderRadius: BorderRadius.circular(16)
      ),
      height: 32,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 8.0),
              child: Text(widget.topicName, style: TextStyle(fontSize: 18)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 16.0),
              child: Text(widget.amount, style: TextStyle(fontSize: 16)),
            ),
          ]),
        ),
      ]),
    );
  }
}

class CategoriesStatBox extends StatefulWidget {
  const CategoriesStatBox({
    super.key,
    required this.topicName,
    required this.amount,
    required this.color,
  });
  final String topicName;
  final String amount;
  final Color color;

  @override
  State<CategoriesStatBox> createState() => _CategoriesStatBoxState();
}

class _CategoriesStatBoxState extends State<CategoriesStatBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 188, 22),
        // borderRadius: BorderRadius.circular(16)
      ),
      height: 32,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 5.0),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(16)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 4.0),
              child: Text(widget.topicName, style: TextStyle(fontSize: 18)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 16.0),
              child: Text(widget.amount, style: TextStyle(fontSize: 16)),
            ),
          ]),
        ),
      ]),
    );
  }
}
