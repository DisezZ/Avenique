import 'dart:math';

import 'package:avenique/src/features/account/models/balance.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:decimal/decimal.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../../../objectbox.g.dart';
import '../../../../utils/convert.dart';
import '../../../account/data/account_repository.dart';
import '../../../account/domain/account.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/domain/category.dart';
import '../../domain/record.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_record_event.dart';
part 'edit_record_state.dart';

class EditRecordBloc extends Bloc<EditRecordEvent, EditRecordState> {
  EditRecordBloc({
    required Store store,
    required RecordRepository recordRepository,
    required AccountRepository accountRepository,
    required CategoryRepository categoryRepository,
    required Record? record,
  })  : _store = store,
        _recordRepository = recordRepository,
        _accountRepository = accountRepository,
        _categoryRepository = categoryRepository,
        super(
          EditRecordState(
            record: record,
            type: record?.type ?? 'Expense',
            amount: record?.amount ?? '0',
            note: record?.note ?? '',
            account: record?.account.target,
            category: record?.category.target,
            dateTime: record?.date ?? DateTime.now(),
          ),
        ) {
    on<EditRecordStarted>(_onEditRecordStarted);
    on<EditRecordTypeChanged>(_onEditRecordTypeChanged);
    on<EditRecordAmountChanged>(_onEditRecordAmountChanged);
    on<EditRecordNoteChanged>(_onEditRecordNoteChanged);
    on<EditRecordAccountChanged>(_onEditRecordAccountChanged);
    on<EditRecordCategoryChanged>(_onEditRecordCategoryChanged);
    on<EditRecordDateTimeChanged>(_onEditRecordDateTimeChanged);
    on<EditRecordSubmitted>(_onEditRecordSubmitted);
    on<EditRecordDeleted>(_onEditRecordDeleted);
  }

  final Store _store;
  final RecordRepository _recordRepository;
  final AccountRepository _accountRepository;
  final CategoryRepository _categoryRepository;

  void _onEditRecordStarted(
    EditRecordStarted event,
    Emitter<EditRecordState> emit,
  ) async {
    final initialAccount = await _accountRepository.getOne(1);
    final initialCategory = await _categoryRepository.getOne(1);

    //state.record.account.target = initialAccount;
    //state.record.category.target = initialCategory;

    emit(state.copyWith(
      account: state.account ?? initialAccount,
      category: state.category ?? initialCategory,
    ));
  }

  void _onEditRecordTypeChanged(
    EditRecordTypeChanged event,
    Emitter<EditRecordState> emitter,
  ) {
    final type = event.type;
    //state.record.type = type;
    emit(state.copyWith(type: type));
  }

  void _onEditRecordAmountChanged(
    EditRecordAmountChanged event,
    Emitter<EditRecordState> emit,
  ) {
    final amount = event.amount;
    print(amount);
    //state.record.amount = amount;
    //print('Amount: ${state.record.amount}');
    emit(state.copyWith(amount: amount));
  }

  void _onEditRecordNoteChanged(
    EditRecordNoteChanged event,
    Emitter<EditRecordState> emit,
  ) {
    final note = event.note;
    //state.record.note = note;
    emit(state.copyWith(note: note));
  }

  void _onEditRecordAccountChanged(
    EditRecordAccountChanged event,
    Emitter<EditRecordState> emit,
  ) {
    final account = event.account;
    //state.record.account.target = account;
    emit(state.copyWith(account: account));
  }

  void _onEditRecordCategoryChanged(
    EditRecordCategoryChanged event,
    Emitter<EditRecordState> emit,
  ) {
    final category = event.category;
    //state.record.category.target = category;
    emit(state.copyWith(category: category));
  }

  void _onEditRecordDateTimeChanged(
    EditRecordDateTimeChanged event,
    Emitter<EditRecordState> emit,
  ) {
    final dateTime = event.dateTime;
    //state.record.date = dateTime;
    emit(state.copyWith(dateTime: dateTime));
  }

  void _onEditRecordSubmitted(
    EditRecordSubmitted event,
    Emitter<EditRecordState> emit,
  ) {
    emit(state.copyWith(status: EditRecordStatus.loading));
    // var record = state.record ??
    //     (Record(type: '', amount: '', note: '', date: DateTime.now())
    //       ..type = state.type
    //       ..amount = state.amount
    //       ..note = state.note
    //       ..account.target = state.account
    //       ..category.target = state.category
    //       ..date = state.dateTime);
    print(state.isNew);
    try {
      if (state.isNew) {
        final record = (Record(
            type: state.type,
            amount: state.amount,
            note: state.note,
            date: state.dateTime)
          ..account.target = state.account
          ..category.target = state.category);
        var accountBalance =
            Convert.convertStringToDecimal(record.account.target!.balance);
        final recordAmount = Convert.convertStringToDecimal(record.amount);
        if (recordAmount.toDouble() == 0) {
          emit(state.copyWith(status: EditRecordStatus.failure));
          return;
        }
        print('Record Amount: $recordAmount');
        if (record.type == 'Expense') {
          accountBalance -= recordAmount;
        } else {
          accountBalance += recordAmount;
        }

        record.account.target!.balance =
            Convert.convertDecimalToString(accountBalance);
        record.amount = Convert.convertDecimalToString(recordAmount);
        _store.runInTransaction(TxMode.write, () {
          _recordRepository.insert(record);
          _accountRepository.update(record.account.target!);
        });
        print('Add Record');
      } else {
        final previousRecord = state.record!;
        final currentRecord = (Record(
            type: state.type,
            amount: state.amount,
            note: state.note,
            date: state.dateTime)
          ..id = previousRecord.id
          ..account.target = state.account
          ..category.target = state.category);
        if (Convert.convertStringToDecimal(currentRecord.amount).toDouble() ==
            0) {
          emit(state.copyWith(status: EditRecordStatus.failure));
          return;
        }

        final previousAccount = previousRecord.account.target!;
        var previousAccountBalance =
            Convert.convertStringToDecimal(previousAccount.balance);
        final previousRecordAmount =
            Convert.convertStringToDecimal(previousRecord.amount) *
                Decimal.fromInt((previousRecord.type == 'Expense' ? 1 : -1));
        previousAccountBalance += previousRecordAmount;
        previousAccount.balance =
            Convert.convertDecimalToString(previousAccountBalance);

        var currentAccount = state.account!;
        currentAccount = currentAccount.name == previousAccount.name
            ? previousAccount
            : currentAccount;
        var currentAccountBalance =
            Convert.convertStringToDecimal(currentAccount.balance);
        final currentRecordAmount =
            Convert.convertStringToDecimal(currentRecord.amount) *
                Decimal.fromInt((currentRecord.type == 'Expense' ? -1 : 1));
        currentAccountBalance += currentRecordAmount;
        currentAccount.balance =
            Convert.convertDecimalToString(currentAccountBalance);

        currentRecord.amount = Convert.convertDecimalToString(
            currentRecordAmount.abs()); // remove last dot

        _store.runInTransaction(TxMode.write, () {
          _recordRepository.update(currentRecord);
          _accountRepository.update(previousAccount);
          _accountRepository.update(currentAccount);
        });
        print('Edit Record');
      }
      emit(state.copyWith(status: EditRecordStatus.success));
    } catch (e) {
      print('Failed');
      emit(state.copyWith(status: EditRecordStatus.failure));
    }
  }

  void _onEditRecordDeleted(
    EditRecordDeleted event,
    Emitter<EditRecordState> emit,
  ) {
    print('Try delete me!');
    final record = state.record!;
    if (record != null) {
      try {
        final account = record.account.target;
        final recordAmount = Convert.convertStringToDecimal(record.amount);

        if (account != null) {
          final previousAccountBalance =
              Convert.convertStringToDecimal(account.balance);
          final newAccountBalance = previousAccountBalance +
              recordAmount *
                  (record.type == 'Expense'
                      ? Decimal.fromInt(1)
                      : Decimal.fromInt(-1));
          account.balance = Convert.convertDecimalToString(newAccountBalance);
          _store.runInTransaction(TxMode.write, () {
            _recordRepository.delete(record.id);
            _accountRepository.update(account);
          });
        } else {
          _store.runInTransaction(TxMode.write, () {
            _recordRepository.delete(record.id);
          });
        }
        emit(state.copyWith(status: EditRecordStatus.success));
      } catch (e) {
        print('failed');
        emit(state.copyWith(status: EditRecordStatus.failure));
      }
    }
  }
}


// state.record.type = state.type;
    // state.record.amount = state.amount;
    // state.record.note = state.note;
    // state.record.account.target = state.account;
    // state.record.category.target = state.category;
    // state.record.date = state.dateTime;

    // if (state.isNew) {
    //   try {
    //     _recordRepository.insert(state.record);
    //     emit(state.copyWith(status: EditRecordStatus.success));
    //   } catch (e) {
    //     emit(state.copyWith(status: EditRecordStatus.failure));
    //   }
    // } else {
    //   try {
    //     _recordRepository.update(state.record);
    //     emit(state.copyWith(status: EditRecordStatus.success));
    //   } catch (e) {
    //     emit(state.copyWith(status: EditRecordStatus.failure));
    //   }
    // }