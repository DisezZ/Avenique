part of 'statistic_bloc.dart';

class StatisticState extends Equatable {
  StatisticState({
    List<FlSpot>? flSpots,
    List<Account>? selectedAccount,
  })  : flSpots = flSpots ?? [],
        selectedAccount = selectedAccount ?? [];

  final List<Account> selectedAccount;
  final List<FlSpot> flSpots;

  StatisticState copyWith({
    List<FlSpot>? flSpots,
    List<Account>? selectedAccount,
  }) {
    return StatisticState(
      flSpots: flSpots ?? this.flSpots,
      selectedAccount: selectedAccount ?? this.selectedAccount,
    );
  }

  @override
  List<Object> get props => [flSpots, selectedAccount];
}
