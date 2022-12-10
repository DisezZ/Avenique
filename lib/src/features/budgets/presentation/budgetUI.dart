import 'package:flutter/material.dart';

class BudgetsBox extends StatefulWidget {
  const BudgetsBox({super.key});

  @override
  State<BudgetsBox> createState() => _BudgetsBoxState();
}

class _BudgetsBoxState extends State<BudgetsBox> {
  double barPercentage = 0.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 31.0, right: 31.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 225),
              borderRadius: BorderRadius.circular(15)),
          height: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 8),
                child: Text(
                  'Monthly:',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 222, 222, 225),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Text(
                        'Note',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 9.0, top: 5),
                      child: Text(
                        'Set: 5000 THB',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 10.0, bottom: 5, right: 10),
                child: Stack(
                  children: [
                    Container(
                      height: 24,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 360 * barPercentage,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 252, 127, 127),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0))),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'remain:2500 THB (50%)',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'Durations: 1 week',
                        style: TextStyle(fontSize: 12),
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

class BudgetsContainerBar extends StatefulWidget {
  const BudgetsContainerBar({super.key});

  @override
  State<BudgetsContainerBar> createState() => _BudgetsContainerBarState();
}

class _BudgetsContainerBarState extends State<BudgetsContainerBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 222, 222, 225),
            borderRadius: BorderRadius.circular(16),
          ),
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 15.0),
                      child: Icon(
                        Icons.data_usage_sharp,
                        size: 30,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 13),
                            child: Text(
                              'Budgets',
                              style: TextStyle(fontSize: 18),
                            ),
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
