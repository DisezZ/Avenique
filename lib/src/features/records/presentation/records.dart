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
        padding: const EdgeInsets.only(left: 27.0, right: 27.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 225),
              borderRadius: BorderRadius.circular(16)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 12),
              child: Text(
                'Last Records',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            //DateTimeTest(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 6, bottom: 10),
              child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
      padding: const EdgeInsets.only(top: 7.0, bottom: 17),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Icon(
              Icons.fastfood_sharp,
              size: 32,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Text(
                    'Category Name:',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Text(
                    'Note:',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 225),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('-5000 THB', style: TextStyle(fontSize: 18)),
                    Text('Date: 12/8/2002', style: TextStyle(fontSize: 14))
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 222, 222, 225),
                    borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }
}
