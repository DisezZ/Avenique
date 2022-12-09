import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../data/account_repository.dart';
import '../../domain/account.dart';
import '../../edit/bloc/edit_account_bloc.dart';
import '../../models/models.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  static Route<void> route(
      {required BuildContext context, Account? initialAccount}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<EditAccountBloc>(
        create: (_) => EditAccountBloc(
          accountRepository: RepositoryProvider.of<AccountRepository>(context),
          account: initialAccount,
        ),
        child: const EditAccountScreen(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<EditAccountBloc, EditAccountState>(
  //     builder: (context, state) => Text(state.isNew.toString()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditAccountBloc, EditAccountState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == FormzStatus.submissionSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<EditAccountBloc, EditAccountState>(
          builder: (context, state) {
            return Column(
              children: [
                Text('AddAccountView '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account Name:'),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<EditAccountBloc>()
                            .add(EditAccountNameStarted());
                        Navigator.of(context)
                            .push(AddAccountNameScreen.route(context));
                      },
                      child: Text(state.account.name),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class AddAccountNameScreen extends StatelessWidget {
  const AddAccountNameScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<EditAccountBloc>(context),
        child: const AddAccountNameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditAccountBloc, EditAccountState>(
      listenWhen: (previous, current) =>
          previous.nameStatus != current.nameStatus &&
          current.nameStatus == FormzStatus.submissionSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<EditAccountBloc, EditAccountState>(
          builder: (context, state) {
            final String? errorText;
            if (state.name.invalid &&
                state.name.error == NameValidationError.empty) {
              errorText = "Account name can't be empty";
            } else if (state.nameStatus == FormzStatus.submissionCanceled) {
              errorText = "Account with this name already exists";
            } else if (state.nameStatus == FormzStatus.submissionFailure) {
              errorText = 'Unexpected error occured, please try again';
            } else {
              errorText = null;
            }
            return Column(
              children: [
                TextFormField(
                  initialValue: state.name.value,
                  onChanged: (value) => context
                      .read<EditAccountBloc>()
                      .add(EditAccountNameChanged(name: value)),
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: errorText,
                  ),
                ),
                Text(state.name.value),
                ElevatedButton(
                    onPressed: (() {
                      context
                          .read<EditAccountBloc>()
                          .add(const EditAccountNameSubmitted());
                    }),
                    child: Text('Add')),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  inputFormatters: [ThousandsFormatter(allowFraction: true)],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//      return BlocBuilder<AccountBloc, AccountState>(
//       builder: (BuildContext context, state) {
//         if (state is AccountInitial) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (state is AddAccountedSuccess) {
//           return AccountCard(account: state.account);
//         }
//         if (state is AddAccountedFailure) {
//           return Text(state.message);
//         }
//         return Text('Non');
//       },
//     );