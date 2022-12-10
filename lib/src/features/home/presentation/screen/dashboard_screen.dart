import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/setting/presentation/screen/setting_screen.dart';
import 'package:avenique/src/features/statistics/presentation/balance_trend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../objectbox.g.dart';
import '../../../account/domain/account.dart';
import '../../../account/presentation/account_list/account_card_list.dart';
import '../../../record/data/record_repository.dart';
import '../../../record/presentation/record_list/record_tile.dart';
import '../../../record/presentation/screen/edit_record_screen.dart';
import '../../../record/presentation/screen/records_overview.dart';
import '../../../statistics/presentation/balance_stat.dart';
import '../../../statistics/presentation/stat.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountRepository = RepositoryProvider.of<AccountRepository>(context);
    final recordRepository = RepositoryProvider.of<RecordRepository>(context);

    final accountStream = accountRepository.getAll().asBroadcastStream();
    final recordStream = recordRepository.getAll().asBroadcastStream();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avenique'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).push(SettingScreen.route(context)),
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          StreamBuilder<List<Account>>(
            stream: accountStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final accounts = snapshot.data!;
                return AccountCardList(accounts: accounts);
              }
            },
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BalanceTrend(),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Latest Records'),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                RecordsOverviewScreen.route(context: context),
                              ),
                              child: Icon(Icons.more_horiz),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        StreamBuilder(
                          stream: recordStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final records = snapshot.data!;
                              return Column(
                                children: records.asMap().entries.map((entry) {
                                  if (entry.key < 4) {
                                    return RecordTile(record: entry.value);
                                  } else {
                                    return Container();
                                  }
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          BalanceTrendContainer(),
          SizedBox(height: 500),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async => Navigator.of(context)
            .push(await EditRecordScreen.route(context, null)),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
