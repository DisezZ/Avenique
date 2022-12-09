import './dashboardPage.dart';
import './planningPage.dart';
import './statPage.dart';
import 'package:flutter/material.dart';
import 'src/features/account/presentation/accountUi.dart';
import 'src/features/account/presentation/accountModel.dart';
import 'src/features/stat/presentation/statUi.dart';
import './testpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avenique"),
      ),
      body: StatPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_board, color: Colors.blue),
            label: 'First Icon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_flags_rounded, color: Colors.blue),
            label: 'Second Icon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded, color: Colors.blue),
            label: 'Third Icon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help, color: Colors.blue),
            label: 'Fourth Icon',
          ),
        ],
      ),
    );
  }
}
