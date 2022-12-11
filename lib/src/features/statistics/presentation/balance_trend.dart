import 'dart:math';

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
import 'package:intl/intl.dart';

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
                  Decimal maxBalance = totalBalance;
                  Decimal minBalance = totalBalance;
                  var previousBalance = totalBalance;
                  for (var record in records) {
                    balanceHistory[record.date] ??=
                        Convert.convertDecimalToString(previousBalance);
                    final recordAmount =
                        Convert.convertStringToDecimal(record.amount) *
                            Decimal.fromInt(record.type == 'Expense' ? 1 : -1);
                    final newBalance = Convert.convertStringToDecimal(
                            balanceHistory[record.date]!) +
                        recordAmount;
                    balanceHistory[record.date] =
                        Convert.convertDecimalToString(newBalance);
                    if (newBalance > maxBalance) {
                      maxBalance = newBalance;
                    }
                    if (newBalance < minBalance) {
                      minBalance = newBalance;
                    }
                    previousBalance = newBalance;
                  }
                  balanceHistory[pastDate] =
                      Convert.convertDecimalToString(previousBalance);

                  // for (var recordGroup in groupedRecords.entries) {
                  //   recordGroup.value.forEach((record) {
                  //     balanceHistory[recordGroup.key] ??=
                  //         Convert.convertDecimalToString(previousBalance);
                  //     final recordAmount = Convert.convertStringToDecimal(
                  //             record.amount) *
                  //         Decimal.fromInt(record.type == 'Expense' ? 1 : -1);
                  //     final newBalance = Convert.convertStringToDecimal(
                  //             balanceHistory[recordGroup.key]!) +
                  //         recordAmount;
                  //     balanceHistory[recordGroup.key] =
                  //         Convert.convertDecimalToString(newBalance);
                  //   });
                  //   previousBalance = Convert.convertStringToDecimal(
                  //       balanceHistory[recordGroup.key]!);
                  // }

                  // for (var i = 0;; i++) {
                  //   final currentDate = DateTime(presentDate.year,
                  //       presentDate.month, presentDate.day - i);
                  //   balanceHistory[currentDate] ??= '0';
                  //   Decimal currentCashflow = Convert.convertStringToDecimal(
                  //       balanceHistory[currentDate]!);
                  //   for (var record in groupedRecords[currentDate] ?? []) {
                  //     currentCashflow += Convert.convertStringToDecimal(
                  //             record.amount) *
                  //         Decimal.fromInt(record.type == 'Expense' ? -1 : 1);
                  //   }
                  //   balanceHistory[currentDate] =
                  //       Convert.convertDecimalToString(currentCashflow);

                  //   balanceHistory[currentDate] =
                  //       Convert.convertDecimalToString(
                  //           Convert.convertStringToDecimal(
                  //                   balanceHistory[currentDate]!) +
                  //               currentBalance);
                  //   currentBalance = Convert.convertStringToDecimal(
                  //       balanceHistory[currentDate]!);
                  //   if (currentBalance > maxBalance) {
                  //     maxBalance = currentBalance;
                  //   }
                  //   if (currentBalance > minBalance) {
                  //     minBalance = currentBalance;
                  //   }

                  //   // print(
                  //   //     'HESdas: ${balanceHistory[currentDate]} ${pastDate} ${currentDate}');
                  //   if (currentDate.isAtSameMomentAs(pastDate)) {
                  //     break;
                  //   }
                  //   // break;
                  // }

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
                      // print('Total Balance: ${totalBalance.toDouble()}');
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: BalanceTrendGraph(
                                  balanceHistory: balanceHistory,
                                  minBalance: minBalance,
                                  maxBalance: maxBalance,
                                ),
                              ),
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
  BalanceTrendGraph({
    super.key,
    required this.balanceHistory,
    required this.maxBalance,
    required this.minBalance,
  });

  final Map<DateTime, String> balanceHistory;
  final Decimal minBalance, maxBalance;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    balanceHistory.entries
        .forEach((element) => print('${element.key} ${element.value}'));
    final presentDate = DateTime.now();
    final pastDate =
        DateTime(presentDate.year, presentDate.month - 1, presentDate.day);
    final minX = pastDate.millisecondsSinceEpoch.toDouble();
    final maxX = presentDate.millisecondsSinceEpoch.toDouble();
    final minY = minBalance.toDouble();
    final maxY = maxBalance.toDouble();

    print('${minY} ${maxY}');

    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY + (log((maxY - minY).ceil()) / log(10)).round() / 2,
          lineBarsData: [
            _lineChartBarData(),
          ],
          borderData: FlBorderData(
            show: false,
          ),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                //interval: (maxX - minX) / 100 * 35,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  axisSide: AxisSide.bottom,
                  child: Text(DateFormat('dd/MM').format(
                      DateTime.fromMillisecondsSinceEpoch(value.toInt()))),
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                //interval: (maxX - minX) / 100 * 5,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  axisSide: AxisSide.bottom,
                  child: Text(
                      NumberFormat.compactCurrency(symbol: '\$').format(value)),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  LineChartBarData _lineChartBarData() {
    return LineChartBarData(
      spots: [
        for (var current in balanceHistory.entries)
          FlSpot(current.key.millisecondsSinceEpoch.toDouble(),
              Convert.convertStringToDecimal(current.value).toDouble()),
      ],
      isCurved: true,
      curveSmoothness: 0.1,
      // gradient: LinearGradient(
      //   colors: gradientColors,
      // ),
      belowBarData: BarAreaData(
        show: true,
      ),
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    String caseDateZero = getDateMonth(30);
    String caseDateFive = getDateMonth(25);
    String caseDateTen = getDateMonth(20);
    String caseDateFifteen = getDateMonth(15);
    String caseDateTwenty = getDateMonth(10);
    String caseDateTwentyfive = getDateMonth(5);
    const style = TextStyle(
      color: Color.fromARGB(255, 177, 188, 199),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(caseDateZero, style: style);
        break;
      case 5:
        text = Text(caseDateFive, style: style);
        break;
      case 10:
        text = Text(caseDateTen, style: style);
        break;
      case 15:
        text = Text(caseDateFifteen, style: style);
        break;
      case 20:
        text = Text(caseDateTwenty, style: style);
        break;
      case 25:
        text = Text(caseDateTwentyfive, style: style);
        break;
      case 30:
        text = const Text('TODAY', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  String getDateMonth(int durations) {
    DateTime startDate = DateTime.now();
    var newDate =
        DateTime(startDate.year, startDate.month, startDate.day - durations);
    String dateMonthString = DateFormat('dd/MM').format(newDate);
    //print('New DATE: $newDate');
    return dateMonthString;
  }
}
