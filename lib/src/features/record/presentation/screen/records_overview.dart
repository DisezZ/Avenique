import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:avenique/src/features/record/overview/bloc/record_overview_bloc.dart';
import 'package:avenique/src/features/record/presentation/record_list/record_tile.dart';
import 'package:avenique/src/features/record/presentation/record_list/record_tile_list.dart';
import 'package:avenique/src/features/record/presentation/screen/edit_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../domain/record.dart';

class RecordsOverviewScreen extends StatelessWidget {
  const RecordsOverviewScreen({super.key});

  static Route<void> route({required BuildContext context}) {
    return MaterialPageRoute(
      builder: (_) => RepositoryProvider.value(
        value: RepositoryProvider.of<RecordRepository>(context),
        child: BlocProvider(
          create: (_) => RecordOverviewBloc(
              recordRepository:
                  RepositoryProvider.of<RecordRepository>(context)),
          child: RecordsOverviewScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recordRepository = RepositoryProvider.of<RecordRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: StreamBuilder(
        stream: recordRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.hasData) {
            final records = snapshot.data!;

            final groupedRecords = groupRecordToDateMap(records);
            return Padding(
              padding: EdgeInsets.all(24),
              child: buildGroupedRecordsList(context, groupedRecords),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildGroupedRecordsList(
      BuildContext context, Map<DateTime, List<Record>> groupedRecords) {
    return Column(
      children: groupedRecords.entries
          .map((entry) => Column(
                children: [
                  buildGroupedRecords(context, entry),
                  const SizedBox(height: 32),
                ],
              ))
          .toList(),
    );
  }

  Widget buildGroupedRecords(
      BuildContext context, MapEntry<DateTime, List<Record>> recordGrouped) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('E, dd MMM yyyy').format(recordGrouped.key)),
            Column(
              children: recordGrouped.value
                  .map((element) => RecordTile(record: element))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  static Map<DateTime, List<Record>> groupRecordToDateMap(
      List<Record> records) {
    Map<DateTime, List<Record>> map = {};
    records.forEach((element) {
      map[DateTime(element.date.year, element.date.month, element.date.day)] ??=
          [];
      map[DateTime(element.date.year, element.date.month, element.date.day)]!
          .add(element);
    });
    return map;
  }
}




            // return Column(
            //   children: recordsGrouped.entries.map((entry) {
            //     return Column(
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(color: Colors.amber),
            //           child: Column(
            //             children: [
            //               Text(DateFormat('E, dd MMM yyyy').format(entry.key)),
            //               Column(
            //                 children: entry.value
            //                     .map((element) => RecordTile(record: element))
            //                     .toList(),
            //               )
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: 16,
            //         )
            //       ],
            //     );
            //   }).toList(),
            // );
            //return RecordTileList(records: records);
            // return GroupedListView<Record, DateTime>(
            //   elements: records,
            //   groupBy: (element) => DateTime(
            //       element.date.year, element.date.month, element.date.day),
            //   groupSeparatorBuilder: (value) =>
            //       Text(DateFormat('E, dd MMM yyyy').format(value)),
            //   itemBuilder: (context, element) => RecordTile(record: element),
            // );
            // return StickyGroupedListView<Record, DateTime>(
            //   elements: records,
            //   order: StickyGroupedListOrder.DESC,
            //   groupBy: (element) => DateTime(
            //       element.date.year, element.date.month, element.date.day),
            //   groupSeparatorBuilder: (element) =>
            //       Text(DateFormat('E, dd MMM yyyy').format(element.date)),
            //   itemBuilder: (context, element) => RecordTile(record: element),
            // );