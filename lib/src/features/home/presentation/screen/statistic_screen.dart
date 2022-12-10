import 'package:flutter/material.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const statisticList = [
      Card(child: ListTile(title: Text('Spending'))),
      Card(child: ListTile(title: Text('Balance'))),
      Card(child: ListTile(title: Text('Outlook'))),
      Card(child: ListTile(title: Text('Cashflow'))),
      Card(child: ListTile(title: Text('Report'))),
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
