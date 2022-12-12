import 'package:flutter/material.dart';

class PaymentsOverview extends StatelessWidget {
  const PaymentsOverview({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(builder: (context) => PaymentsOverview());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
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
                          padding: const EdgeInsets.only(top: 14.0, right: 10),
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
      ),
    );
  }
}
