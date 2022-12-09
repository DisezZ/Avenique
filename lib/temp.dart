import 'package:flutter/material.dart';
import 'src/features/account/presentation/accountUi.dart';
import 'src/features/account/presentation/accountModel.dart';

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
  List<AccountModel> accountList = [
    AccountModel("account-A", "1000"),
    AccountModel("account-B", "1000")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avenique"),
      ),
      body: ListView.builder(
          itemCount: accountList.length,
          itemBuilder: (BuildContext context, int index) {
            AccountModel accountInfo = accountList[index];
            return ListTile(
              title: Text(accountInfo.accountName),
              subtitle: Text(accountInfo.accounBalance),
            );
          }),
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
/*
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avenique"),
      ),
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

      List<>
      /*
        body: Center(
          child: Column(children: const <Widget>[
            Text(
              "Line--1",
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            Text(
              "Line--2",
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            Text(
              "Line--3",
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
          ]),
        )
        */
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.audiotrack),
      ),
      */
      //body: Container(),
    );
  }
}
*/
