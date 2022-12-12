part of 'edit_account_bloc.dart';

enum EditAccountStatus { initial, loading, success, failure }

class EditAccountState extends Equatable {
  const EditAccountState({
    this.status = EditAccountStatus.initial,
    required this.account,
    this.name = '',
    this.balance = '0',
    this.tbdName = const Name.pure(),
    this.tbdNameStatus = FormzStatus.pure,
  });

  final EditAccountStatus status;
  final Account? account;
  final String name;
  final String balance;

  final Name tbdName;
  final FormzStatus tbdNameStatus;

  bool get isNew => account == null;

  EditAccountState copyWith({
    EditAccountStatus? status,
    Account? account,
    String? name,
    String? balance,
    Name? tbdName,
    FormzStatus? tbdNameStatus,
  }) {
    return EditAccountState(
      status: status ?? this.status,
      account: account ?? this.account,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      tbdName: tbdName ?? this.tbdName,
      tbdNameStatus: tbdNameStatus ?? this.tbdNameStatus,
    );
  }

  @override
  List<Object?> get props => [status, account, name, balance, tbdName, tbdNameStatus];
}
