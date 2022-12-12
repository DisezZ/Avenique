import 'package:flutter/material.dart';

class OutlookStatScreen extends StatelessWidget {
  const OutlookStatScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => OutlookStatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double barPercentage = 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text('Outlook Statistics'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Container(),
      ),
    );
  }
}
