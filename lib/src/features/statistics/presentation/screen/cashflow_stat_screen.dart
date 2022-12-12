import 'package:flutter/material.dart';

class CashflowStatScreen extends StatelessWidget {
  const CashflowStatScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => CashflowStatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cashflow Statistics'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
