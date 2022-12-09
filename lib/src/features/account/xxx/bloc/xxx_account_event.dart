part of 'xxx_account_bloc.dart';

abstract class XXXAccountEvent extends Equatable {
  const XXXAccountEvent();

  @override
  List<Object> get props => [];
}

class XXXAccountNameChanged extends XXXAccountEvent {
  const XXXAccountNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class XXXAccountBalanceChanged extends XXXAccountEvent {
  const XXXAccountBalanceChanged(this.balance);

  final String balance;

  @override
  List<Object> get props => [balance];
}

class XXXAccountNameSubmitted extends XXXAccountEvent {
  const XXXAccountNameSubmitted();
}

class XXXAccountBalanceSubmitted extends XXXAccountEvent {
  const XXXAccountBalanceSubmitted();
}

class XXXAccountSubmitted extends XXXAccountEvent {
  const XXXAccountSubmitted();
}
