import 'package:avenique/src/common_widgets/custom_number_field.dart';
import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/presentation/screen/select_account_screen.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:avenique/src/features/record/edit/bloc/edit_record_bloc.dart';
import 'package:avenique/src/features/record/presentation/screen/edit_record_note_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../../objectbox.g.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/presentation/screen/select_category_screen.dart';
import '../../domain/record.dart';

class EditRecordScreen extends StatelessWidget {
  const EditRecordScreen({super.key});

  static Future<Route<void>> route(
      BuildContext context, Record? initialRecord) async {
    // final accountRepository = RepositoryProvider.of<AccountRepository>(context);
    // final categoryRepository =
    //     RepositoryProvider.of<CategoryRepository>(context);
    // final initialAccount = await accountRepository.getOne(1);
    // final initialCategory = await categoryRepository.getOne(1);

    // initialRecord ??=
    //     Record(type: 'Expense', amount: '0', note: '', date: DateTime.now())
    //       ..account.target = initialAccount
    //       ..category.target = initialCategory;

    return MaterialPageRoute(
      builder: (_) => BlocProvider<EditRecordBloc>(
        create: (_) => EditRecordBloc(
          store: RepositoryProvider.of<Store>(context),
          recordRepository: RepositoryProvider.of<RecordRepository>(context),
          accountRepository: RepositoryProvider.of<AccountRepository>(context),
          categoryRepository:
              RepositoryProvider.of<CategoryRepository>(context),
          record: initialRecord,
        ),
        child: const EditRecordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const isNew = false;
    
    final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    editRecordBloc.add(EditRecordStarted());

    return BlocListener<EditRecordBloc, EditRecordState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditRecordStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: editRecordBloc.state.isNew
              ? Text('Add Record')
              : Text('Edit Record'),
        ),
        body: BlocBuilder<EditRecordBloc, EditRecordState>(
          builder: (context, state) {
            //final record = state.record;
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CupertinoSlidingSegmentedControl<String>(
                          groupValue: state.type,
                          children: {
                            'Expense': buildSegment('Expense'),
                            'Income': buildSegment('Income'),
                          },
                          onValueChanged: (type) => editRecordBloc.add(
                            EditRecordTypeChanged(
                                type: type ?? state.type),
                          ),
                        ),
                      ),
                      CustomNumberField(
                        initialAmount: state.amount,
                        callback: (value) {
                          editRecordBloc
                              .add(EditRecordAmountChanged(amount: value));
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                              EditRecordNoteScreen.route(
                                  context, state.note));
                          if (result != null) {
                            editRecordBloc
                                .add(EditRecordNoteChanged(note: result));
                          }
                        },
                        child: Text('Edit Note'),
                      ),
                      ListTile(
                        title: Text('Account'),
                        trailing:
                            Text('${state.account?.name ?? 'None'} >'),
                        onTap: () async {
                          final result = await Navigator.of(context)
                              .push(SelectAccountScreen.route(context));
                          if (result != null) {
                            print(result.name);
                            editRecordBloc
                                .add(EditRecordAccountChanged(account: result));
                          }
                        },
                      ),
                      ListTile(
                        title: Text('Category'),
                        trailing:
                            Text('${state.category?.name ?? 'None'} >'),
                        onTap: () async {
                          final result = await Navigator.of(context)
                              .push(SelectCategoryScreen.route(context));
                          if (result != null) {
                            print(result.name);
                            editRecordBloc.add(
                                EditRecordCategoryChanged(category: result));
                          }
                        },
                      ),
                      ListTile(
                        title: Text('Date'),
                        trailing: Text(
                            '${DateFormat('E, dd MMM yyyy').format(state.dateTime)} >'),
                        onTap: () => DatePicker.showDatePicker(
                          context,
                          onConfirm: (date) => editRecordBloc
                              .add(EditRecordDateTimeChanged(dateTime: date)),
                        ),
                      ),
                      ListTile(
                        title: Text('Time'),
                        trailing: Text(
                            '${DateFormat('HH:mm').format(state.dateTime)} >'),
                        onTap: () => DatePicker.showTimePicker(
                          context,
                          showSecondsColumn: false,
                          onConfirm: (time) => editRecordBloc
                              .add(EditRecordDateTimeChanged(dateTime: time)),
                        ),
                      ),
                      Expanded(child: Container()),
                      ElevatedButton(
                          onPressed: () =>
                              editRecordBloc.add(EditRecordSubmitted()),
                          child: Text('DONE'))
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildSegment(String text) => Container(
        padding: EdgeInsets.all(8),
        child: Text(text),
      );
}
