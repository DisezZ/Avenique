import 'package:flutter/material.dart';
import './src/features/stat/presentation/statUIbar.dart';
import './src/features/stat/presentation/balanceStatUI.dart';
import './src/features/stat/presentation/spendingStatUI.dart';
import './src/features/stat/presentation/cashflowStatUI.dart';
import './src/features/stat/presentation/reportsStatUI.dart';
import './src/features/stat/presentation/outlookStatUI.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: BalanceContainerBar(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: BalanceAllAccStatGraph(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: BalanceAllAccStatBar(),
        // ),

        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OutlookContainerBar(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OutlookAllAccStat(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OutlookAllAccStatGraph(),
        ),

        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: CashflowContainerBar(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: CashflowAllAccStatBar(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: CashflowAllAccStatGraph(),
        // ),

        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: SpendingContainerBar(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: SpendingPieCStatContainer(),
        // ),

        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: ReportContainerBar(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 12),
        //   child: ReportsAllAccStatBar(),
        // ),
      ],
    );
  }
}
