import 'package:avenique/src/features/goal/data/goal_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../objectbox.g.dart';
import '../../domain/goal.dart';
import '../../edit/bloc/edit_goal_bloc.dart';

class EditGoalScreen extends StatefulWidget {
  const EditGoalScreen({super.key});

  static Route<void> route(BuildContext context, {Goal? initialGoal}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider(
        create: (context) => EditGoalBloc(
          store: RepositoryProvider.of<Store>(context),
          goalRepository: RepositoryProvider.of<GoalRepository>(context),
          goal: initialGoal,
        ),
        child: const EditGoalScreen(),
      ),
    );
  }

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  final _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _endDateController.value = TextEditingValue(
        text: DateFormat('dd MMM yyyy')
            .format(BlocProvider.of<EditGoalBloc>(context).state.endDate));
  }

  @override
  void dispose() {
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editGoalBloc = BlocProvider.of<EditGoalBloc>(context);
    editGoalBloc.add(EditGoalStarted());
    final isNew = editGoalBloc.state.isNew;

    return BlocListener<EditGoalBloc, EditGoalState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditGoalStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: editGoalBloc.state.isNew
              ? const Text('New goal')
              : const Text('Edit goal'),
          actions: [
            isNew ? Container() : _buildDeleteAction(context),
            isNew ? _buildAddAction(context) : _buildSaveAction(context),
          ],
        ),
        body: BlocBuilder<EditGoalBloc, EditGoalState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: state.name,
                            onChanged: (value) => editGoalBloc
                                .add(EditGoalNameChanged(name: value)),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(),
                              hintText: 'Goal name',
                              labelText: 'Goal name',
                            ),
                          ),
                          SizedBox(height: 16),
                          Divider(thickness: 1, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('Amount', textAlign: TextAlign.left),
                          SizedBox(height: 16),
                          TextFormField(
                            initialValue: state.targetAmount,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => editGoalBloc.add(
                                EditGoalTargetAmountChanged(
                                    targetAmount: value)),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(),
                              hintText: 'Target amount',
                              labelText: 'Target amount',
                            ),
                            inputFormatters: [
                              ThousandsFormatter(allowFraction: true)
                            ],
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            initialValue: state.currentAmount,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => editGoalBloc.add(
                                EditGoalCurrentAmountChanged(
                                    currentAmount: value)),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(),
                              hintText: 'Initial amount',
                              labelText: 'Initial amount',
                            ),
                            inputFormatters: [
                              ThousandsFormatter(allowFraction: true)
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(thickness: 1, color: Colors.grey),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _endDateController,
                            onTap: () => _selectDate(context),
                            readOnly: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(),
                              hintText: 'End date',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddAction(BuildContext context) {
    final editGoalBloc = BlocProvider.of<EditGoalBloc>(context);
    return TextButton(
      onPressed: () => editGoalBloc.add(EditGoalSubmitted()),
      child: Text('Add'),
    );
  }

  Widget _buildSaveAction(BuildContext context) {
    final editGoalBloc = BlocProvider.of<EditGoalBloc>(context);
    return TextButton(
      onPressed: () => editGoalBloc.add(EditGoalSubmitted()),
      child: Text('Save'),
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    final editGoalBloc = BlocProvider.of<EditGoalBloc>(context);
    return IconButton(
      //onPressed: () => editGoalBloc.add(EditGoalDeleted()),
      onPressed: () =>
          _buildDeleteActionConfirmationDialog(context, editGoalBloc),
      icon: const Icon(Icons.delete),
    );
  }

  void _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      // setState(() {
      //   _endDateController.value = TextEditingValue(
      //       text: DateFormat('dd MMM yyyy').format(newDate).toString());
      // });
      BlocProvider.of<EditGoalBloc>(context)
          .add(EditGoalEndDateChanged(endDate: newDate));
    }
  }

  void _buildDeleteActionConfirmationDialog(
      BuildContext context, EditGoalBloc bloc) async {
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
                      bloc.add(EditGoalDeleted());
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
              ],
            ));
  }
}
