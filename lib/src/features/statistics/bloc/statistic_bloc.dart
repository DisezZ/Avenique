import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../account/domain/account.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  StatisticBloc() : super(StatisticState()) {
    on<StatisticStarted>(_onStatisticStarted);
  }

  void _onStatisticStarted(
    StatisticStarted event,
    Emitter<StatisticState> emit,
  ) {
    emit(state.copyWith(
      selectedAccount: event.selectedAccount,
    ));
  }
}
