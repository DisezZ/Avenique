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
import 'package:fluttericon/font_awesome_icons.dart';
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
      fullscreenDialog: true,
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
    final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    editRecordBloc.add(EditRecordStarted());
    final isNew = editRecordBloc.state.isNew;

    return BlocListener<EditRecordBloc, EditRecordState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditRecordStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: editRecordBloc.state.isNew
              ? const Text('New record')
              : const Text('Edit record'),
          actions: [
            isNew ? Container() : _buildDeletection(context),
            isNew ? _buildAddAction(context) : _buildSaveAction(context),
          ],
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
                      SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: CupertinoSlidingSegmentedControl<String>(
                          groupValue: state.type,
                          children: {
                            'Expense': _buildSegment('Expense'),
                            'Income': _buildSegment('Income'),
                          },
                          onValueChanged: (type) => editRecordBloc.add(
                            EditRecordTypeChanged(type: type ?? state.type),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        height: 320,
                        child: Stack(
                          children: [
                            CustomNumberField(
                              initialAmount: state.amount,
                              callback: (value) {
                                print(value);
                                editRecordBloc.add(
                                    EditRecordAmountChanged(amount: value));
                              },
                            ),
                            Positioned(
                              right: 0,
                              bottom: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final result = await Navigator.of(context)
                                        .push(EditRecordNoteScreen.route(
                                            context, state.note));
                                    if (result != null) {
                                      editRecordBloc.add(
                                          EditRecordNoteChanged(note: result));
                                    }
                                  },
                                  icon: Icon(FontAwesome.edit),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Account'),
                              trailing:
                                  Text('${state.account?.name ?? 'None'} >'),
                              onTap: () async {
                                final result = await Navigator.of(context)
                                    .push(SelectAccountScreen.route(context));
                                if (result != null) {
                                  print(result.name);
                                  editRecordBloc.add(EditRecordAccountChanged(
                                      account: result));
                                }
                              },
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
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
                                  editRecordBloc.add(EditRecordCategoryChanged(
                                      category: result));
                                }
                              },
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            ListTile(
                              title: Text('Date'),
                              trailing: Text(
                                  '${DateFormat('E, dd MMM yyyy').format(state.dateTime)} >'),
                              onTap: () => _selectDate(context, editRecordBloc),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            ListTile(
                              title: Text('Time'),
                              trailing: Text(
                                  '${DateFormat('HH:mm').format(state.dateTime)} >'),
                              onTap: () => _selectTime(context, editRecordBloc),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(child: Container()),
                      // ElevatedButton(
                      //     onPressed: () =>
                      //         editRecordBloc.add(EditRecordSubmitted()),
                      //     child: Text('DONE'))
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

  Widget _buildSegment(String text) => Container(
        padding: EdgeInsets.all(8),
        child: Text(text),
      );

  Widget _buildAddAction(BuildContext context) {
    final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    return TextButton(
      onPressed: () => editRecordBloc.add(EditRecordSubmitted()),
      child: Text('Add'),
    );
  }

  Widget _buildSaveAction(BuildContext context) {
    final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    return TextButton(
      onPressed: () => editRecordBloc.add(EditRecordSubmitted()),
      child: Text('Save'),
    );
  }

  Widget _buildDeletection(BuildContext context) {
    final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    return IconButton(
      //onPressed: () => editRecordBloc.add(EditRecordDeleted()),
      onPressed: () =>
          _buildDeleteActionConfirmationDialog(context, editRecordBloc),
      icon: const Icon(Icons.delete),
    );
  }

  void _buildDeleteActionConfirmationDialog(
      BuildContext context, EditRecordBloc bloc) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete record'),
              content: Text('Are you sure to delete this record?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      bloc.add(EditRecordDeleted());
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
              ],
            ));
  }

  void _selectDate(BuildContext context, EditRecordBloc bloc) async {
    final dateTime = bloc.state.dateTime;

    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(dateTime.year - 5),
      lastDate: DateTime(dateTime.year + 5),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      final newDateTime = DateTime(newDate.year, newDate.month, newDate.day,
          dateTime.hour, dateTime.minute);
      BlocProvider.of<EditRecordBloc>(context)
          .add(EditRecordDateTimeChanged(dateTime: newDate));
    }
  }

  void _selectTime(BuildContext context, EditRecordBloc bloc) async {
    //final editRecordBloc = BlocProvider.of<EditRecordBloc>(context);
    final dateTime = bloc.state.dateTime;
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
    if (newTime != null) {
      final newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
          newTime.hour, newTime.minute);
      print('Time Changed');
      bloc.add(EditRecordDateTimeChanged(dateTime: newDateTime));
    }
  }
}
