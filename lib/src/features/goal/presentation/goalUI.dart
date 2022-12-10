import 'package:flutter/material.dart';

class GoalBox extends StatefulWidget {
  const GoalBox({super.key});

  @override
  State<GoalBox> createState() => _GoalBoxState();
}

class _GoalBoxState extends State<GoalBox> {
  double barPercentage = 0.75;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 31.0, right: 31.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 222, 225),
                borderRadius: BorderRadius.circular(16)),
            height: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 11.0),
                        child: Icon(
                          Icons.airplane_ticket_sharp,
                          size: 46,
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 9),
                              child: Text(
                                'Category Lorem 4',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Text(
                                'Category Lorem 4',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 14.0, right: 12),
                              child: Text(
                                'Set: 5000 THB',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text(
                                'Date: 1/1/2022',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 10.0, bottom: 8, right: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 24,
                          width: 360,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Container(
                          height: 24,
                          width: 360 * barPercentage,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 102, 163, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0))),
                        ),
                      ],
                    )),
                Container(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Text('Saved: 11,250 THB (75%)',
                          style: TextStyle(fontSize: 12)),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: Text('Desired: 15 Nov 2022',
                          style: TextStyle(fontSize: 12)),
                    ),
                  ]),
                ),
              ],
            )),
      ),
    );
  }
}

class GoalsContainerBar extends StatefulWidget {
  const GoalsContainerBar({super.key});

  @override
  State<GoalsContainerBar> createState() => _GoalsContainerBarState();
}

class _GoalsContainerBarState extends State<GoalsContainerBar> {
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
                        Icons.card_giftcard_sharp,
                        size: 30,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 14),
                            child: Text(
                              'Goals',
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
