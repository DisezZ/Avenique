part of 'statistic_bloc.dart';

abstract class StatisticEvent extends Equatable {
  const StatisticEvent();

  @override
  List<Object> get props => [];
}

class StatisticStarted extends StatisticEvent {
  const StatisticStarted({
    required this.selectedAccount
  });

  final List<Account> selectedAccount;
}