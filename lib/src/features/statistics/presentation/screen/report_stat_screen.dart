import 'package:flutter/material.dart';

class ReportStatScreen extends StatelessWidget {
  const ReportStatScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => ReportStatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Statistics'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
