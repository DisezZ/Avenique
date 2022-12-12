import 'package:avenique/src/features/goal/presentation/screen/goals_overview_screen.dart';
import 'package:flutter/material.dart';

import '../../../budget/presentation/screen/budgets_overview.dart';
import '../../../payment/presentation/screen/payments_overview.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final planningList = [
      Card(
          child: ListTile(
              title: Text('Payment'),
              onTap: () =>
                  Navigator.of(context).push(PaymentsOverview.route(context)))),
      Card(
          child: ListTile(
              title: Text('Budget'),
              onTap: () =>
                  Navigator.of(context).push(BudgetsOverview.route(context)))),
      Card(
          child: ListTile(
              title: Text('Goal'),
              onTap: () => Navigator.of(context)
                  .push(GoalsOverviewScreen.route(context)))),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Planning')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: planningList.length,
          itemBuilder: (context, index) => planningList[index],
          separatorBuilder: (context, index) => SizedBox(height: 16),
        ),
      ),
    );
  }
}
