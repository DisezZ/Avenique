part of 'edit_goal_bloc.dart';

enum EditGoalStatus { initial, loading, success, failure }

class EditGoalState extends Equatable {
  EditGoalState({
    this.status = EditGoalStatus.initial,
    this.goal,
    this.name = '',
    this.targetAmount = '0',
    this.currentAmount = '0',
    DateTime? endDate,
  }) : endDate = endDate ?? DateTime.now();

  final EditGoalStatus status;
  final Goal? goal;
  final String name;
  final String targetAmount;
  final String currentAmount;
  final DateTime endDate;

  bool get isNew => goal == null;

  EditGoalState copyWith({
    EditGoalStatus? status,
    Goal? goal,
    String? name,
    String? targetAmount,
    String? currentAmount,
    DateTime? endDate,
  }) {
    return EditGoalState(
      status: status ?? this.status,
      goal: goal ?? this.goal,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props =>
      [status, goal, isNew, name, targetAmount, currentAmount, endDate];
}
