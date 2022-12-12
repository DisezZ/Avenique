import 'package:avenique/src/utils/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../objectbox.g.dart';
import '../../data/goal_repository.dart';
import '../../domain/goal.dart';
import '../../edit/bloc/edit_goal_bloc.dart';
import 'edit_goal_screen.dart';

class GoalsOverviewScreen extends StatefulWidget {
  const GoalsOverviewScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => GoalsOverviewScreen(),
    );
  }

  @override
  State<GoalsOverviewScreen> createState() => _GoalsOverviewScreenState();
}

class _GoalsOverviewScreenState extends State<GoalsOverviewScreen> {
  late String addedAmount;

  @override
  void initState() {
    super.initState();
    setState(() {
      addedAmount = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    final goalRepository = RepositoryProvider.of<GoalRepository>(context);
    final goalStream = goalRepository.getAll();
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
      ),
      body: StreamBuilder(
        stream: goalStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error Loading');
          } else if (snapshot.hasData) {
            final goals = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16),
              child: ListView.separated(
                  itemBuilder: (_, index) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          EditGoalScreen.route(
                            context,
                            initialGoal: goals[index],
                          ),
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.flag),
                                title: Text(goals[index].name),
                                subtitle: Text(
                                  'Target date: ${DateFormat('dd/MM/yyyy').format(goals[index].endDate)}',
                                ),
                                trailing: IconButton(
                                  onPressed: () =>
                                      _showAddAmountDialog(context, goals[index]),
                                  icon: Icon(Icons.add),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 360,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 360 *
                                          (Convert.convertStringToDecimal(
                                                      goals[index]
                                                          .currentAmount) /
                                                  Convert
                                                      .convertStringToDecimal(
                                                          goals[index]
                                                              .targetAmount))
                                              .toDouble(),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saved: ${goals[index].currentAmount}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Goal: ${goals[index].targetAmount}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (_, index) {
                    if (index != goals.length - 1) {
                      return const SizedBox(
                        height: 16,
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: goals.length),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(EditGoalScreen.route(context)),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddAmountDialog(BuildContext context, Goal goal) async {
    final editGoalBloc = EditGoalBloc(store: RepositoryProvider.of<Store>(context), goalRepository: RepositoryProvider.of<GoalRepository>(context), goal: goal);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add amount to goal'),
              content: TextFormField(
                initialValue: addedAmount,
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {
                  addedAmount = value;
                }),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Add amount',
                  labelText: 'Add amount',
                ),
                inputFormatters: [ThousandsFormatter(allowFraction: true)],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      editGoalBloc
                          .add(EditGoalAmountAdded(amount: addedAmount));
                      Navigator.pop(context);
                    },
                    child: Text('Add')),
              ],
            ));
  }
}
