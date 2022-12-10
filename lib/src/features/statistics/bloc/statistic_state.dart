part of 'statistic_bloc.dart';

class StatisticState extends Equatable {
  StatisticState({
    List<Account>? selectedAccount,
  }) : selectedAccount = selectedAccount ?? [];

  final List<Account> selectedAccount;

  StatisticState copyWith({
    List<Account>? selectedAccount,
  }) {
    return StatisticState(
      selectedAccount: selectedAccount ?? this.selectedAccount,
    );
  }
  
  @override
  List<Object> get props => [selectedAccount];
}
