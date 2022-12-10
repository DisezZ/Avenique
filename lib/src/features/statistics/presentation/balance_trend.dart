import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/presentation/account_list/account_card.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:avenique/src/features/record/presentation/screen/records_overview.dart';
import 'package:avenique/src/features/statistics/bloc/statistic_bloc.dart';
import 'package:avenique/src/utils/convert.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../account/domain/account.dart';

class BalanceTrend extends StatelessWidget {
  const BalanceTrend({super.key});

  @override
  Widget build(BuildContext context) {
    final statisticBloc = StatisticBloc();
    final accountRepository = RepositoryProvider.of<AccountRepository>(context);
    final recordRepository = RepositoryProvider.of<RecordRepository>(context);
    final accountStream = accountRepository.getAll().asBroadcastStream();
    final recordStream = recordRepository.getAll().asBroadcastStream();

    return Container(
      child: StreamBuilder(
          stream: accountStream,
          builder: (context, accountSnapshot) {
            return StreamBuilder(
              stream: recordStream,
              builder: (context, recordSnapshot) {
                if (accountSnapshot.hasData && recordSnapshot.hasData) {
                  final accounts = accountSnapshot.data!;
                  final records = recordSnapshot.data!;

                  final List<int> selected = [0, 2, 3];
                  final Map<int, bool> selectedMap = {};
                  accounts.asMap().forEach((key, value) =>
                      selected.contains(key)
                          ? selectedMap[key] = true
                          : selectedMap[key] = false);
                  print(selectedMap.toString());
                  final List<Account> filteredAccount = [];
                  accounts.asMap().forEach((key, value) =>
                      selectedMap[key]! ? filteredAccount.add(value) : null);
                  Decimal totalBalance = Decimal.fromInt(0);
                  for (var account in filteredAccount) {
                    totalBalance +=
                        Convert.convertStringToDecimal(account.balance);
                  }

                  Map<DateTime, String> balanceHistory = {};
                  final presentDate = DateTime.now();
                  final pastDate = DateTime(
                      presentDate.year, presentDate.month - 1, presentDate.day);
                  final groupedRecords =
                      RecordsOverviewScreen.groupRecordToDateMap(records);
                  Decimal currentBalance = totalBalance;
                  for (var i = 0;; i++) {
                    final currentDate = DateTime(presentDate.year,
                        presentDate.month, presentDate.day - i);
                    balanceHistory[currentDate] ??= '0';
                    Decimal currentCashflow = Convert.convertStringToDecimal(
                        balanceHistory[currentDate]!);
                    for (var record in groupedRecords[currentDate] ?? []) {
                      currentCashflow += Convert.convertStringToDecimal(
                              record.amount) *
                          Decimal.fromInt(record.type == 'Expense' ? -1 : 1);
                    }
                    balanceHistory[currentDate] =
                        Convert.convertDecimalToString(currentCashflow);

                    balanceHistory[currentDate] =
                        Convert.convertDecimalToString(
                            Convert.convertStringToDecimal(
                                    balanceHistory[currentDate]!) +
                                currentBalance);
                    currentBalance = Convert.convertStringToDecimal(
                        balanceHistory[currentDate]!);

                    print(
                        'HESdas: ${balanceHistory[currentDate]} ${pastDate} ${currentDate}');
                    if (currentDate.isAtSameMomentAs(pastDate)) {
                      break;
                    }
                    // break;
                  }

                  statisticBloc
                      .add(StatisticStarted(selectedAccount: filteredAccount));
                  return BlocBuilder<StatisticBloc, StatisticState>(
                    bloc: statisticBloc,
                    builder: (context, state) {
                      var totalBalance = Decimal.fromInt(0);
                      for (var account in state.selectedAccount) {
                        totalBalance +=
                            Convert.convertStringToDecimal(account.balance);
                      }
                      //final groupedRecords = RecordsOverviewScreen.groupRecordToDateMap();
                      print('Total Balance: ${totalBalance.toDouble()}');
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Balance Trend'),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(Icons.more_horiz),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              BalanceTrendGraph(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('Text');
                }
              },
            );
          }),
    );
  }
}

class BalanceTrendGraph extends StatelessWidget {
  const BalanceTrendGraph({super.key, required this.balance});

  final Map<DateTime, String> balance;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
          LineChartData(minX: 0, maxX: 11, minY: 0, maxY: 6, lineBarsData: [
        LineChartBarData(spots: [FlSpot(0, 3)])
      ])),
    );
  }
}
