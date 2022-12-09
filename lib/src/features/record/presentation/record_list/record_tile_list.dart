import 'package:avenique/src/features/record/presentation/record_list/record_tile.dart';
import 'package:flutter/material.dart';

import '../../domain/record.dart';

class RecordTileList extends StatelessWidget {
  List<Record> records;

  RecordTileList({super.key, required this.records,});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) => RecordTile(record: records[index]),
    );
  }
}