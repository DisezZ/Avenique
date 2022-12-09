import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/account.dart';

part 'xxx_account_event.dart';
part 'xxx_account_state.dart';

class XXXAccountBloc extends Bloc<XXXAccountEvent, XXXAccountState> {
  XXXAccountBloc({
    required AccountRepository accountRepository,
    required Account? initialAccount,
  })  : _accountRepository = accountRepository,
        super(
          XXXAccountState(
            initialAccount: initialAccount,
            name: initialAccount?.name ?? '',
            balance: initialAccount?.balance ?? '',
          ),
        ) {
    on<XXXAccountNameChanged>(_onXXXAccountNameChanged);
    on<XXXAccountBalanceChanged>(_onXXXAccountBalanceChanged);
    on<XXXAccountNameSubmitted>(_onXXXAccountNameSubmitted);
    on<XXXAccountBalanceSubmitted>(_onXXXAccountBalanceSubmitted);
    on<XXXAccountSubmitted>(_onXXXAccountSubmitted);
  }

  final AccountRepository _accountRepository;

  void _onXXXAccountNameChanged(
    XXXAccountNameChanged event,
    Emitter<XXXAccountState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onXXXAccountBalanceChanged(
    XXXAccountBalanceChanged event,
    Emitter<XXXAccountState> emit,
  ) {
    emit(state.copyWith(balance: event.balance));
  }

  void _onXXXAccountNameSubmitted(
    XXXAccountNameSubmitted event,
    Emitter<XXXAccountState> emit,
  ) {}

  void _onXXXAccountBalanceSubmitted(
    XXXAccountBalanceSubmitted event,
    Emitter<XXXAccountState> emit,
  ) {}

  void _onXXXAccountSubmitted(
    XXXAccountSubmitted event,
    Emitter<XXXAccountState> emit,
  ) {}
}
