/************************************
 * dashboard.dart 
 * To manage dashboard page r
 * return Listview
 * 
 */

import 'package:flutter/material.dart';

import 'src/features/account/presentation/accountUi.dart';
import 'src/features/stat/presentation/statUi.dart';
import 'src/features/records/presentation/records.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Text('test'),
    // );
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 19),
          child: AccountDashContainer(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 47),
          child: BalanceTrendContainer(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 19),
          child: RecordsContainer(),
        ),
      ],
    );
    // return ListView.separated(
    //   itemBuilder: (context, index) => Container(
    //     decoration:
    //         const BoxDecoration(color: Color.fromARGB(255, 154, 38, 38)),
    //     height: 310,
    //     width: double.infinity,
    //   ),
    //   separatorBuilder: (context, index) => const SizedBox(
    //     height: 12,
    //   ),
    //   itemCount: 3,
    // );
  }
}
