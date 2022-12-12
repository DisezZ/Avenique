import 'package:flutter/material.dart';

class SpendingStatScreen extends StatelessWidget {
  const SpendingStatScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => SpendingStatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Statistics'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
