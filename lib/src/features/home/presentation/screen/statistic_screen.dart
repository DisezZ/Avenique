import 'package:avenique/src/features/statistics/presentation/screen/spending_stat_screen.dart';
import 'package:flutter/material.dart';

import '../../../statistics/presentation/screen/balance_stat_screen.dart';
import '../../../statistics/presentation/screen/cashflow_stat_screen.dart';
import '../../../statistics/presentation/screen/outlook_stat_screen.dart';
import '../../../statistics/presentation/screen/report_stat_screen.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final statisticList = [
      Card(
        child: ListTile(
          title: Text('Spending'),
          onTap: () => Navigator.of(context).push(
            SpendingStatScreen.route(context),
          ),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('Balance'),
          onTap: () => Navigator.of(context).push(
            BalanceStatScreen.route(context),
          ),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('Outlook'),
          onTap: () => Navigator.of(context).push(
            OutlookStatScreen.route(context),
          ),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('Cashflow'),
          onTap: () => Navigator.of(context).push(
            CashflowStatScreen.route(context),
          ),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('Report'),
          onTap: () => Navigator.of(context).push(
            ReportStatScreen.route(context),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Statistic')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: statisticList.length,
          itemBuilder: (context, index) => statisticList[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
        ),
      ),
    );
  }
}
