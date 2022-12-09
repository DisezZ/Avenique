part of 'edit_record_bloc.dart';

enum EditRecordStatus { initial, loading, success, failure }

class EditRecordState extends Equatable {
  EditRecordState({
    this.status = EditRecordStatus.initial,
    this.type = 'Expense',
    this.record,
    this.amount = '0',
    this.note = '',
    this.account,
    this.category,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  final EditRecordStatus status;
  final Record? record;
  final String type;
  final String amount;
  final String note;
  final Account? account;
  final Category? category;
  final DateTime dateTime;

  bool get isNew => record == null;

  EditRecordState copyWith({
    EditRecordStatus? status,
    Record? record,
    String? type,
    String? amount,
    String? note,
    Account? account,
    Category? category,
    DateTime? dateTime,
  }) {
    return EditRecordState(
      status: status ?? this.status,
      record: record ?? this.record,
      //isNew: isNew,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      account: account ?? this.account,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object?> get props =>
      [status, record, isNew, type, amount, note, account, category, dateTime];
}

// class EditRecordState extends Equatable {
  // const EditRecordState({
  //   this.status = FormzStatus.pure,
  //   required this.account,
  //   required this.isNew,
  //   this.balance = const Balance.pure(),
  // });

  // final FormzStatus status;
  // final Record record;
  // final bool isNew;
  // final String type;
  // final Balance balance;
  // final Account account;
  // final Category category;
  // final DateTime dateTime;

  // EditRecordState copyWith({
  //   FormzStatus? status,
  //   Account? account,
  //   bool? isNew,
  //   Name? name,
  //   FormzStatus? nameStatus,
  //   Balance? balance,
  // }) {
  //   return EditRecordState(
  //     status: status ?? this.status,
  //     account: account ?? this.account,
  //     isNew: isNew ?? this.isNew,
  //     name: name ?? this.name,
  //     nameStatus: nameStatus ?? this.nameStatus,
  //     balance: balance ?? this.balance,
  //   );
  // }

  // @override
  //List<Object> get props => [status, account, name, nameStatus, balance];
// }
