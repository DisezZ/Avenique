part of 'xxx_account_bloc.dart';

enum XXXAccountStatus { initial, loading, success, failure }

class XXXAccountState extends Equatable {
  const XXXAccountState({
    this.status = XXXAccountStatus.initial,
    this.initialAccount,
    this.name = '',
    this.balance = '',
  });

  final XXXAccountStatus status;
  final Account? initialAccount;
  final String name;
  final String balance;

  bool get isNew => initialAccount == null;

  XXXAccountState copyWith({
    XXXAccountStatus? status,
    Account? initialAccount,
    String? name,
    String? balance,
  }) {
    return XXXAccountState(
      status: status ?? this.status,
      initialAccount: initialAccount ?? this.initialAccount,
      name: name ?? this.name,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [status, initialAccount, name, balance];
}
