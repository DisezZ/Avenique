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
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        title: const Text(
          "Avenique",
          style: TextStyle(
            color: Color.fromARGB(255, 102, 165, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const dashboardPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 96, 197, 255),
        unselectedItemColor: const Color.fromARGB(255, 144, 144, 144),
        currentIndex: index,
        onTap: (int num) {
          setState(() {
            index = num;
          });
        },
        items: const [
          BottomNavigationBarItem(
            //backgroundColor: Color.fromARGB(255, 233, 233, 233),
            label: 'Dashboard',
            icon: Icon(
              Icons.featured_play_list_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Planning',
            icon: Icon(
              Icons.flag_sharp,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Statistic',
            icon: Icon(
              Icons.auto_graph,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Help',
            icon: Icon(
              Icons.help_center,
            ),
          ),
        ],
      ),
    );
  }
}
