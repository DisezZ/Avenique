import 'package:avenique/src/features/account/presentation/account_list/account_card.dart';
import 'package:avenique/src/features/account/presentation/account_list/add_account_card.dart';
import 'package:flutter/material.dart';

import '../../domain/account.dart';

class AccountCardList extends StatelessWidget {
  final List<Account> accounts;

  const AccountCardList({
    super.key,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    final accoutCardList = accounts.asMap().entries.map<Widget>(
      (entries) {
        if (entries.key == 0) {
          return Container(
            padding: EdgeInsets.only(left: 24),
            child: AccountCard(
              account: entries.value,
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.only(left: 12),
            child: AccountCard(
              account: entries.value,
            ),
          );
        }
      },
    ).toList();
    accoutCardList.add(Container(
      padding: EdgeInsets.only(left: 12, right: 24),
      child: const AddAccountCard(),
    ));

    return SizedBox(
      height: 85,
      child: Scrollbar(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: accoutCardList,
        ),
      ),
    );
  }
}

/*
ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                padding: EdgeInsets.only(left: 24),
                child: AccountCard(
                  account: accounts[index],
                ),
              );
            } else if (index == accounts.length - 1) {
              return Container(
                padding: EdgeInsets.only(right: 24),
                child: AddAccountCard(),
              );
            } else {
              return AccountCard(
                account: accounts[index],
              );
            }
          },
          separatorBuilder: (context, _) => const SizedBox(
            width: 12,
          ),
        )
*/