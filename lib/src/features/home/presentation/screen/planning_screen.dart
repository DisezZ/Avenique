import 'package:flutter/material.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const planningList = [
      Card(child: ListTile(title: Text('Payment'))),
      Card(child: ListTile(title: Text('Budget'))),
      Card(child: ListTile(title: Text('Goal'))),
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
