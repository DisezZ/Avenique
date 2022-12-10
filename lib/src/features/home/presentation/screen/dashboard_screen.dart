import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/setting/presentation/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../objectbox.g.dart';
import '../../../account/domain/account.dart';
import '../../../account/presentation/account_list/account_card_list.dart';
import '../../../record/data/record_repository.dart';
import '../../../record/presentation/record_list/record_tile.dart';
import '../../../record/presentation/screen/edit_record_screen.dart';
import '../../../record/presentation/screen/records_overview.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountRepository =
        LocalAccountRepository(store: RepositoryProvider.of<Store>(context));
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
          StreamBuilder(
            stream: accountRepository.getAll(),
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
                Card(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ],
                    ),
                  ),
                ),
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
                          stream:
                              RepositoryProvider.of<RecordRepository>(context)
                                  .getAll(),
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
