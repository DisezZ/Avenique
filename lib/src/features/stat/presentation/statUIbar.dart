import 'package:flutter/material.dart';

class BalanceContainerBar extends StatefulWidget {
  const BalanceContainerBar({super.key});

  @override
  State<BalanceContainerBar> createState() => _BalanceContainerBarState();
}

class _BalanceContainerBarState extends State<BalanceContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 246, 221),
                borderRadius: BorderRadius.circular(16)),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2, left: 8.0),
                        child: Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 55,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, left: 5),
                            child: Text('Balances',
                                style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      )),
                    ])),
              ],
            )),
      ),
    );
  }
}

class OutlookContainerBar extends StatefulWidget {
  const OutlookContainerBar({super.key});

  @override
  State<OutlookContainerBar> createState() => _OutlookContainerBarState();
}

class _OutlookContainerBarState extends State<OutlookContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 246, 221),
                borderRadius: BorderRadius.circular(16)),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2, left: 8.0),
                        child: Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 55,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, left: 5),
                            child:
                                Text('Outlook', style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      )),
                    ])),
              ],
            )),
      ),
    );
  }
}

class CashflowContainerBar extends StatefulWidget {
  const CashflowContainerBar({super.key});

  @override
  State<CashflowContainerBar> createState() => _CashflowContainerBarState();
}

class _CashflowContainerBarState extends State<CashflowContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 246, 221),
                borderRadius: BorderRadius.circular(16)),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2, left: 8.0),
                        child: Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 55,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, left: 5),
                            child: Text('Cashflow',
                                style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      )),
                    ])),
              ],
            )),
      ),
    );
  }
}

class SpendingContainerBar extends StatefulWidget {
  const SpendingContainerBar({super.key});

  @override
  State<SpendingContainerBar> createState() => _SpendingContainerBarState();
}

class _SpendingContainerBarState extends State<SpendingContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 225),
              borderRadius: BorderRadius.circular(16)),
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 8.0),
                      child: Icon(
                        Icons.bar_chart_sharp,
                        size: 30,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 5),
                            child: Text('Spending',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportContainerBar extends StatefulWidget {
  const ReportContainerBar({super.key});

  @override
  State<ReportContainerBar> createState() => _ReportContainerBarState();
}

class _ReportContainerBarState extends State<ReportContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 246, 221),
                borderRadius: BorderRadius.circular(16)),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2, left: 8.0),
                        child: Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 55,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0, left: 5),
                            child:
                                Text('Report', style: TextStyle(fontSize: 24)),
                          ),
                        ],
                      )),
                    ])),
              ],
            )),
      ),
    );
  }
}
