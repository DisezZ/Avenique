import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../account/domain/account.dart';
import '../../record/domain/record.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AccountRepository accountRepository,
    required RecordRepository recordRepository,
  })  : _accountRepository = accountRepository,
        _recordRepository = recordRepository,
        super(HomeState(
          accountStream: accountRepository.getAll().asBroadcastStream(),
          recordStream: recordRepository.getAll().asBroadcastStream(),
        )) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final AccountRepository _accountRepository;
  final RecordRepository _recordRepository;
}
