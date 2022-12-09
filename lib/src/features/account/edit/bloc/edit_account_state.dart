part of 'edit_account_bloc.dart';

class EditAccountState extends Equatable {
  const EditAccountState({
    this.status = FormzStatus.pure,
    required this.account,
    required this.isNew,
    this.name = const Name.pure(),
    this.nameStatus = FormzStatus.pure,
    this.balance = const Balance.pure(),
  });

  final FormzStatus status;
  final Account account;
  final bool isNew;
  final Name name;
  final FormzStatus nameStatus;
  final Balance balance;

  EditAccountState copyWith({
    FormzStatus? status,
    Account? account,
    bool? isNew,
    Name? name,
    FormzStatus? nameStatus,
    Balance? balance,
  }) {
    return EditAccountState(
      status: status ?? this.status,
      account: account ?? this.account,
      isNew: isNew ?? this.isNew,
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object> get props => [status, account, name, nameStatus, balance];
}
