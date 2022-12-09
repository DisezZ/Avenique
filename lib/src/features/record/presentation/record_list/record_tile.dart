import 'package:avenique/src/features/record/presentation/screen/edit_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/record.dart';

class RecordTile extends StatelessWidget {
  final Record record;

  const RecordTile({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final category = record.category.target!;
    final amount = record.amount;
    final date = record.date;

    return ListTile(
      title: Text(category.name),
      subtitle: Text(DateFormat('E, dd MMM yyyy').format(date)),
      trailing: Text(amount),
      onTap: () async => Navigator.of(context)
          .push(await EditRecordScreen.route(context, record)),
    );
  }
}
