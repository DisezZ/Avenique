import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/presentation/screen/edit_account_screen.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:avenique/src/features/record/presentation/screen/records_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsOverviewScreen extends StatelessWidget {
  const AccountsOverviewScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => AccountsOverviewScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountRepository = RepositoryProvider.of<AccountRepository>(context);
    final accountStream = accountRepository.getAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Setting'),
      ),
      body: StreamBuilder(
        stream: accountStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error Loading');
          } else if (snapshot.hasData) {
            final accounts = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                child: ListView.separated(
                    itemBuilder: (_, index) => ListTile(
                          leading: Icon(Icons.account_balance),
                          title: Text(accounts[index].name),
                          trailing: Text(accounts[index].balance),
                          onTap: () => Navigator.of(context).push(
                            EditAccountScreen.route(context,
                              initialAccount: accounts[index],
                            ),
                          ),
                        ),
                    separatorBuilder: (_, index) {
                      if (index != accounts.length - 1) {
                        return const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: accounts.length),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
