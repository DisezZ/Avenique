import 'package:flutter/material.dart';

class PlanPaymentBox extends StatefulWidget {
  const PlanPaymentBox({super.key});

  @override
  State<PlanPaymentBox> createState() => _PlanPaymentBoxState();
}

class _PlanPaymentBoxState extends State<PlanPaymentBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 31.0, right: 31.0),
        child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 222, 225),
                borderRadius: BorderRadius.circular(16)),
            height: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 8.0),
                        child: Icon(
                          Icons.food_bank_sharp,
                          size: 46,
                        ),
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0, left: 5),
                            child: Text('Category Lorem 4',
                                style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Category Lorem 41',
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
                            padding:
                                const EdgeInsets.only(top: 14.0, right: 10),
                            child: Text('Set: 5000 THB',
                                style: TextStyle(fontSize: 14)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0, right: 10),
                            child: Text('Date: 1/1/2022',
                                style: TextStyle(fontSize: 14)),
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

class PlanPaymentContainerBar extends StatefulWidget {
  const PlanPaymentContainerBar({super.key});

  @override
  State<PlanPaymentContainerBar> createState() =>
      _PlanPaymentContainerBarState();
}

class _PlanPaymentContainerBarState extends State<PlanPaymentContainerBar> {
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
                        padding: EdgeInsets.only(top: 15, left: 15.0),
                        child: Icon(
                          Icons.playlist_add_check_sharp,
                          size: 30,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 14),
                            child: Text('Planned Payments',
                                style: TextStyle(fontSize: 18)),
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
