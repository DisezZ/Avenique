import 'package:flutter/material.dart';

class GoalBox extends StatefulWidget {
  const GoalBox({super.key});

  @override
  State<GoalBox> createState() => _GoalBoxState();
}

class _GoalBoxState extends State<GoalBox> {
  double barPercentage = 0.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 246, 221),
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
                        padding: EdgeInsets.only(top: 2, left: 8.0),
                        child: Icon(
                          Icons.emoji_food_beverage_outlined,
                          size: 54,
                        ),
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0, left: 5),
                            child: Text('Category Lorem 4',
                                style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5),
                            child: Text('Category Lorem 4',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      )),
                      Spacer(),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0, right: 10),
                            child: Text('Set: 5000 THB',
                                style: TextStyle(fontSize: 18)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, right: 10),
                            child: Text('Date: 1/1/2022',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      )),
                    ])),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 5, left: 8.0, bottom: 8),
                    child: Stack(
                      children: [
                        Container(
                          height: 30,
                          width: 360,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Container(
                          height: 30,
                          width: 360 * barPercentage,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0))),
                        ),
                      ],
                    )),
                Container(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('remain:2500 THB (50%)',
                          style: TextStyle(fontSize: 12)),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('Durations: 1 week',
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
                                Text('Goals', style: TextStyle(fontSize: 24)),
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
