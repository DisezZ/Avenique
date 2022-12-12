import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/account/models/name.dart';
import 'package:avenique/src/features/record/edit/bloc/edit_record_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../../../objectbox.g.dart';
import '../../models/models.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc({
    required Store store,
    required AccountRepository accountRepository,
    required Account? account,
  })  : _store = store,
        _accountRepository = accountRepository,
        super(
          EditAccountState(
            account: account,
            name: account?.name ?? '',
            balance: account?.balance ?? '0',
            tbdName: account?.name != null
                ? Name.pure(account!.name)
                : const Name.pure(),
            tbdNameStatus: account?.name != null
                ? Formz.validate([Name.pure(account!.name)])
                : Formz.validate([const Name.pure('')]),
          ),
        ) {
    on<EditAccountStarted>(_onEditAccountStarted);
    on<EditAccountNameStarted>(_onEditAccountNameStarted);
    on<EditAccountNameChanged>(_onEditAccountNameChanged);
    on<EditAccountBalanceChanged>(_onEditAccountBalanceChanged);
    on<EditAccountNameSubmitted>(_onEditAccountNameSubmitted);
    on<EditAccountNameCanceled>(_onEditAccountNameCanceled);
    on<EditAccountSubmitted>(_onEditAccountSubmitted);
    on<EditAccountDeleted>(_onEditAccountDeleted);
  }

  final Store _store;
  final AccountRepository _accountRepository;

  void _onEditAccountStarted(
    EditAccountStarted event,
    Emitter<EditAccountState> emit,
  ) {
    final accounts = _store.box<Account>().getAll();
    final name = state.name == '' ? 'Account ${accounts.length}' : state.name;
    final tbdName = Name.pure(name);
    print('Account Name: $name');
    emit(state.copyWith(
      name: name,
      tbdName: tbdName,
    ));
  }

  void _onEditAccountNameStarted(
    EditAccountNameStarted event,
    Emitter<EditAccountState> emit,
  ) async {
    final tbdName = Name.pure(state.name);
    emit(state.copyWith(
      tbdName: tbdName,
      tbdNameStatus: Formz.validate([tbdName]),
    ));
  }

  void _onEditAccountNameChanged(
    EditAccountNameChanged event,
    Emitter<EditAccountState> emit,
  ) {
    final tbdName = Name.dirty(event.tbdName);
    emit(state.copyWith(
      tbdName: tbdName,
      tbdNameStatus: Formz.validate([tbdName]),
    ));
  }

  void _onEditAccountBalanceChanged(
    EditAccountBalanceChanged event,
    Emitter<EditAccountState> emit,
  ) {
    final balance = event.balance;
    emit(state.copyWith(
      balance: balance,
    ));
  }

  void _onEditAccountNameSubmitted(
    EditAccountNameSubmitted event,
    Emitter<EditAccountState> emit,
  ) async {
    emit(state.copyWith(status: EditAccountStatus.loading));
    try {
      final tbdName = state.tbdName;
      if (state.tbdNameStatus.isValidated) {
        try {
          final result = await _accountRepository.getWithName(tbdName.value);
          print('Result length: ${result.length}');
          if (result.isEmpty) {
            emit(state.copyWith(
                tbdNameStatus: FormzStatus.submissionSuccess,
                name: tbdName.value));
          } else {
            emit(state.copyWith(tbdNameStatus: FormzStatus.submissionCanceled));
          }
        } catch (e) {
          emit(state.copyWith(
            tbdName: tbdName,
            tbdNameStatus: Formz.validate([tbdName]),
          ));
        }
      } else {
        emit(state.copyWith(
          tbdName: tbdName,
          tbdNameStatus: Formz.validate([tbdName]),
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: EditAccountStatus.failure));
    }
  }

  void _onEditAccountNameCanceled(
    EditAccountNameCanceled event,
    Emitter<EditAccountState> emit,
  ) {
    final name = state.name;
    final tbdName = Name.pure(name);
    emit(state.copyWith(
      tbdName: tbdName,
    ));
  }

  void _onEditAccountSubmitted(
    EditAccountSubmitted event,
    Emitter<EditAccountState> emit,
  ) {
    try {
      // if (state.isNew) {
      //   final account = Account(
      //     name: state.name,
      //     balance: state.balance,
      //   );
      // } else {}
      var account = Account(name: state.name, balance: state.balance);
      if (!state.isNew) {
        account.id = state.account!.id;
      }
      //final account = Account(name: state.name, balance: state.balance,);
      _store.runInTransaction(TxMode.write, () {
        _store.box<Account>().put(account);
      });
      emit(state.copyWith(status: EditAccountStatus.success));
    } catch (e) {
      print('Put Record Fail!');
      emit(state.copyWith(status: EditAccountStatus.failure));
    }
  }

  void _onEditAccountDeleted(
    EditAccountDeleted event,
    Emitter<EditAccountState> emit,
  ) {
    final account = state.account;
    try {
      if (account != null) {
        _store.runInTransaction(TxMode.write, () {
          _store.box<Account>().remove(account.id);
        });
      }
      emit(state.copyWith(status: EditAccountStatus.success));
    } catch (e) {
      print('Delete Account Failed!');
      emit(state.copyWith(status: EditAccountStatus.failure));
    }
  }
}


/**
  void _onEditAccountNameSubmitted(
    EditAccountNameSubmitted event,
    Emitter<EditAccountState> emit,
  ) async {
    final name = Name.dirty(state.name.value);
    print(state.status.isValid);
    if (state.status.isValidated) {
      try {
        final result = await _accountRepository.getWithName(name.value);
        print('Result length: ${result.length}');
        if (result.isEmpty) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionCanceled));
        }
      } catch (e) {
        emit(state.copyWith(
          name: name,
          status: Formz.validate([name]),
        ));
      }
    } else {
      emit(state.copyWith(
        name: name,
        status: Formz.validate([name]),
      ));
    }
  }
 */