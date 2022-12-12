import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../screen/edit_account_screen.dart';

class AddAccountCard extends StatelessWidget {
  const AddAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        EditAccountScreen.route(context),
      ),
      child: Card(
        child: AspectRatio(
          aspectRatio: 150 / 85,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                Text('Add Account'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
