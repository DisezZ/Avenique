import 'package:flutter/material.dart';

class RecordsContainer extends StatefulWidget {
  const RecordsContainer({super.key});

  @override
  State<RecordsContainer> createState() => _RecordsContainerState();
}

class _RecordsContainerState extends State<RecordsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 29, 246, 221),
              borderRadius: BorderRadius.circular(16)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Records', style: TextStyle(fontSize: 21))),
            //DateTimeTest(),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8))),
            ),
            RecordsBox(),
            RecordsBox(),
            RecordsBox(),
            RecordsBox(),
            RecordsBox(),
            RecordsBox(),
          ]),
        ),
      ),
    );
  }
}

class RecordsBox extends StatefulWidget {
  const RecordsBox({super.key});

  @override
  State<RecordsBox> createState() => _RecordsBoxState();
}

class _RecordsBoxState extends State<RecordsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.emoji_food_beverage_outlined,
              size: 42,
            ),
          ),
          Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category Name:', style: TextStyle(fontSize: 18)),
                  Text('Note:', style: TextStyle(fontSize: 16))
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 29, 246, 221),
                  borderRadius: BorderRadius.circular(8))),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('-5000 THB', style: TextStyle(fontSize: 18)),
                    Text('Date: 12/8/2002', style: TextStyle(fontSize: 16))
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 246, 221),
                    borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }
}
