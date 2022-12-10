// Dash board account UI

import 'package:flutter/material.dart';

const accountData = [
  {"accountName": "account-1", "accountBalance": "10000"},
  {"accountName": "account-2", "accountBalance": "1000"}
];

class AccountDashboard extends StatefulWidget {
  const AccountDashboard({super.key});
  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  List<dynamic> accountList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 222, 222, 225),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 120,
        width: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 9),
              child: const Icon(
                Icons.account_balance_wallet_sharp,
                size: 50,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'Account:',
                style: TextStyle(
                  color: Color.fromARGB(255, 136, 136, 140),
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 6),
              child: Text(
                'Balance:',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}

class AccountDashContainer extends StatefulWidget {
  const AccountDashContainer({super.key});

  @override
  State<AccountDashContainer> createState() => _AccountDashContainerState();
}

class _AccountDashContainerState extends State<AccountDashContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: AccountDashboard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 11),
          child: AccountDashboard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 11, right: 40),
          child: AccountDashboard(),
        ),
      ]),
    );
  }
}
/*
class _AccountDashboardState extends State<AccountDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.blue),
        height: 100,
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ));
  }
}
*/
