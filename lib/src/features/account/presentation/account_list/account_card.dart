import 'package:flutter/material.dart';

import '../../domain/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 150 / 85,
      child: Card(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
            child: Column(
              children: [
                Text(account.name),
                Text(account.balance),
              ],
            ),
          )),
    );
  }
}

    // SizedBox(
    //   width: 150,
    //   child: Card(
    //       color: Colors.blue,
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
    //         child: Column(
    //           children: [
    //             Text(account.name),
    //             Text(account.balance),
    //           ],
    //         ),
    //       )),
    // );