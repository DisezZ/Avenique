import 'package:avenique/src/features/account/presentation/account_list/account_card.dart';
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
    return SizedBox(
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(left: 40),
              child: AccountCard(
                account: accounts[index],
              ),
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
      ),
    );
  }
}
