part of 'edit_account_bloc.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

// Started
class EditAccountStarted extends EditAccountEvent {
  const EditAccountStarted();
}
class EditAccountNameStarted extends EditAccountEvent {
  const EditAccountNameStarted();
}

// Changed
class EditAccountNameChanged extends EditAccountEvent {
  const EditAccountNameChanged({required this.tbdName});

  final String tbdName;

  @override
  List<Object> get props => [tbdName];
}

class EditAccountBalanceChanged extends EditAccountEvent {
  const EditAccountBalanceChanged({required this.balance});

  final String balance;

  @override
  List<Object> get props => [balance];
}

// Submitted
class EditAccountNameSubmitted extends EditAccountEvent {
  const EditAccountNameSubmitted();
}

class EditAccountBalanceSubmitted extends EditAccountEvent {
  const EditAccountBalanceSubmitted();
}

class EditAccountSubmitted extends EditAccountEvent {
  const EditAccountSubmitted();
}

// Canceled
class EditAccountNameCanceled extends EditAccountEvent {
  const EditAccountNameCanceled();
}

// Deleted
class EditAccountDeleted extends EditAccountEvent {
  const EditAccountDeleted();
}