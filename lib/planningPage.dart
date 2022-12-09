import 'package:flutter/material.dart';
import './src/features/budgets/presentation/budgetUI.dart';
import './src/features/goal/presentation/goalUI.dart';
import './src/features/planpayment/presentation/planedpaymentUI.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});

  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BudgetsContainerBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BudgetsBox(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GoalsContainerBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GoalBox(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: PlanPaymentContainerBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: PlanPaymentBox(),
        ),
      ],
    );
  }
}
