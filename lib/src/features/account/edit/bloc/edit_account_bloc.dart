import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/account/models/name.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc({
    required AccountRepository accountRepository,
    required Account? account,
  })  : _accountRepository = accountRepository,
        super(
          EditAccountState(
            account: account ?? Account(name: 'Account t', balance: ''),
            isNew: account == null ? true : false,
          ),
        ) {
    on<EditAccountNameStarted>(_onEditAccountNameStarted);
    on<EditAccountNameChanged>(_onEditAccountNameChanged);
    on<EditAccountBalanceChanged>(_onEditAccountBalanceChanged);
    on<EditAccountNameSubmitted>(_onEditAccountNameSubmitted);
  }

  final AccountRepository _accountRepository;

  void _onEditAccountNameStarted(
    EditAccountNameStarted event,
    Emitter<EditAccountState> emit,
  ) {
    final name = state.account.name == ''
        ? Name.pure(state.account.name)
        : Name.dirty(state.account.name);
    emit(state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    ));
  }

  void _onEditAccountNameChanged(
    EditAccountNameChanged event,
    Emitter<EditAccountState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    ));
  }

  void _onEditAccountBalanceChanged(
    EditAccountBalanceChanged event,
    Emitter<EditAccountState> emit,
  ) {
    final balance = Balance.dirty(event.balance);
    emit(state.copyWith(
      balance: balance,
    ));
  }

  void _onEditAccountNameSubmitted(
    EditAccountNameSubmitted event,
    Emitter<EditAccountState> emit,
  ) async {
    if (state.nameStatus.isValidated) {
      try {
        final result = await _accountRepository.getWithName(state.name.value);
        if (result.isEmpty) {
          state.account.name = state.name.value;
          print('success');
          emit(state.copyWith(
            nameStatus: FormzStatus.submissionSuccess,
            account: state.account,
          ));
        } else {
          print('canceled');
          emit(state.copyWith(nameStatus: FormzStatus.submissionCanceled));
        }
      } catch (e) {
        print('failure');
        emit(state.copyWith(nameStatus: FormzStatus.submissionCanceled));
      }
    } else {
      print('not validated');
      final name = Name.dirty(state.name.value);
      emit(state.copyWith(
        name: name,
        nameStatus: Formz.validate([name]),
      ));
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