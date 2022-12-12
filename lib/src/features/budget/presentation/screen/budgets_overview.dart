import 'package:flutter/material.dart';

class BudgetsOverview extends StatelessWidget {
  const BudgetsOverview({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(builder: (context) => BudgetsOverview());
  }

  @override
  Widget build(BuildContext context) {
    final barPercentage = 0.6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Butgets'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
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
      ),
    );
  }
}
