import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/account.dart';

class SelectAccountScreen extends StatelessWidget {
  const SelectAccountScreen({super.key, });

  static Route<Account?> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => SelectAccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountRepository = RepositoryProvider.of<AccountRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: StreamBuilder(
        stream: accountRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.hasData) {
            final accounts = snapshot.data!;

            return ListView.separated(
              itemCount: accounts.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(accounts[index].name),
                onTap: () => Navigator.of(context).pop(accounts[index]),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 8,),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}