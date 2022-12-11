import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

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
    final selectedAccount = event.selectedAccount;
    //final List<FlSpot> flSpots = selectedAccount.map((e) => FlSpot(e., y),)
    emit(state.copyWith(
      selectedAccount: event.selectedAccount,
    ));
  }
}
