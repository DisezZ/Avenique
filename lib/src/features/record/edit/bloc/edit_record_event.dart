part of 'edit_record_bloc.dart';

abstract class EditRecordEvent extends Equatable {
  const EditRecordEvent();

  @override
  List<Object> get props => [];
}

// Start
class EditRecordStarted extends EditRecordEvent {
  const EditRecordStarted();
}

// Changed
class EditRecordTypeChanged extends EditRecordEvent {
  const EditRecordTypeChanged({required this.type});

  final String type;

  @override
  List<Object> get props => [type];
}

class EditRecordAmountChanged extends EditRecordEvent {
  const EditRecordAmountChanged({required this.amount});

  final String amount;

  @override
  List<Object> get props => [amount];
}

class EditRecordNoteChanged extends EditRecordEvent {
  const EditRecordNoteChanged({required this.note});

  final String note;

  @override
  List<Object> get props => [note];
}

class EditRecordAccountChanged extends EditRecordEvent {
  const EditRecordAccountChanged({required this.account});

  final Account account;

  @override
  List<Object> get props => [account];
}

class EditRecordCategoryChanged extends EditRecordEvent {
  const EditRecordCategoryChanged({required this.category});

  final Category category;

  @override
  List<Object> get props => [category];
}

class EditRecordDateTimeChanged extends EditRecordEvent {
  const EditRecordDateTimeChanged({required this.dateTime});

  final DateTime dateTime;

  @override
  List<Object> get props => [dateTime];
}

// Submitted
class EditRecordSubmitted extends EditRecordEvent {
  const EditRecordSubmitted();
}


// Delete

class EditRecordDeleted extends EditRecordEvent {
  const EditRecordDeleted();
}