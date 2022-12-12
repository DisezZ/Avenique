import 'package:flutter/material.dart';

class BalanceStatScreen extends StatelessWidget {
  const BalanceStatScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => BalanceStatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Statistics'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
