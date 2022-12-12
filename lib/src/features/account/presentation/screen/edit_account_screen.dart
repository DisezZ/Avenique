import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../../objectbox.g.dart';
import '../../../../common_widgets/custom_number_field.dart';
import '../../data/account_repository.dart';
import '../../domain/account.dart';
import '../../edit/bloc/edit_account_bloc.dart';
import '../../models/models.dart';
import 'select_account_screen.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  static Route<void> route(BuildContext context, {Account? initialAccount}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider<EditAccountBloc>(
        create: (_) => EditAccountBloc(
          store: RepositoryProvider.of<Store>(context),
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
    final editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    editAccountBloc.add(const EditAccountStarted());
    final isNew = editAccountBloc.state.isNew;

    return BlocListener<EditAccountBloc, EditAccountState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditAccountStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          title: editAccountBloc.state.isNew
              ? const Text('New Account')
              : const Text('Edit Account'),
          actions: [
            isNew ? Container() : _buildDeleteAction(context),
            isNew ? _buildAddAction(context) : _buildSaveAction(context),
          ],
        ),
        body: BlocBuilder<EditAccountBloc, EditAccountState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      SizedBox(
                        height: 320,
                        child: CustomNumberField(
                          initialAmount: state.balance,
                          callback: (value) {
                            editAccountBloc
                                .add(EditAccountBalanceChanged(balance: value));
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Account name'),
                              trailing: Text('${state.name} >'),
                              onTap: () {
                                Navigator.of(context)
                                    .push(EditAccountNameScreen.route(context));
                                // if (result != null) {
                                //   editAccountBloc.add(
                                //       EditAccountNameChanged(name: result));
                                // }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            // return Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text('Account Name:'),
            //         ElevatedButton(
            //           onPressed: () {
            //             context
            //                 .read<EditAccountBloc>()
            //                 .add(EditAccountNameStarted());
            //             Navigator.of(context)
            //                 .push(EditAccountNameScreen.route(context));
            //           },
            //           child: Text(state.name.value),
            //         ),
            //       ],
            //     )
            //   ],
            // );
          },
        ),
      ),
    );
  }

  Widget _buildAddAction(BuildContext context) {
    final editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    return TextButton(
      onPressed: () => editAccountBloc.add(EditAccountSubmitted()),
      child: Text('Add'),
    );
  }

  Widget _buildSaveAction(BuildContext context) {
    final editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    return TextButton(
      onPressed: () => editAccountBloc.add(EditAccountSubmitted()),
      child: Text('Save'),
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    final editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    return IconButton(
      // onPressed: () => editAccountBloc.add(EditAccountDeleted()),
      onPressed: () => _buildDeleteActionConfirmationDialog(context, editAccountBloc),
      icon: const Icon(Icons.delete),
    );
  }

  void _buildDeleteActionConfirmationDialog(
      BuildContext context, EditAccountBloc bloc) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete record'),
              content: Text('Are you sure to delete this record?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      bloc.add(EditAccountDeleted());
                      Navigator.pop(context);
                    },
                    child: Text('Yes')),
              ],
            ));
  }
}

class EditAccountNameScreen extends StatefulWidget {
  const EditAccountNameScreen({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<EditAccountBloc>(context),
        child: const EditAccountNameScreen(),
      ),
    );
  }

  @override
  State<EditAccountNameScreen> createState() => _EditAccountNameScreenState();
}

class _EditAccountNameScreenState extends State<EditAccountNameScreen> {
  @override
  Widget build(BuildContext context) {
    final editAccountBloc = BlocProvider.of<EditAccountBloc>(context);
    editAccountBloc.add(const EditAccountNameStarted());

    return WillPopScope(
      onWillPop: () async {
        editAccountBloc.add(EditAccountNameCanceled());
        return true;
      },
      child: BlocListener<EditAccountBloc, EditAccountState>(
        listenWhen: (previous, current) =>
            previous.tbdNameStatus != current.tbdNameStatus &&
            current.tbdNameStatus == FormzStatus.submissionSuccess,
        listener: (context, state) => Navigator.of(context).pop(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Account Name'),
            actions: [
              TextButton(
                onPressed: () =>
                    editAccountBloc.add(const EditAccountNameSubmitted()),
                child: const Text('Save'),
              ),
            ],
          ),
          body: BlocBuilder<EditAccountBloc, EditAccountState>(
            builder: (context, state) {
              final String? errorText;
              if (state.tbdName.invalid &&
                  state.tbdName.error == NameValidationError.empty) {
                errorText = "Account name can't be empty";
              } else if (state.tbdNameStatus ==
                  FormzStatus.submissionCanceled) {
                errorText = "Account with this name already exists";
              } else if (state.tbdNameStatus == FormzStatus.submissionFailure) {
                errorText = 'Unexpected error occured, please try again';
              } else {
                errorText = null;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  TextFormField(
                    initialValue: state.tbdName.value,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) => context
                        .read<EditAccountBloc>()
                        .add(EditAccountNameChanged(tbdName: value)),
                    //keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: errorText,
                    ),
                  ),
                  // errorText == null ? SizedBox() : Text('Error Text',
                  //         style: TextStyle(color: Colors.red),
                  //       ),
                  Expanded(child: Container()),
                ],
              );
            },
          ),
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