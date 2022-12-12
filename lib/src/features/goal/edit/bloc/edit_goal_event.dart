part of 'edit_goal_bloc.dart';

abstract class EditGoalEvent extends Equatable {
  const EditGoalEvent();

  @override
  List<Object> get props => [];
}

// Start
class EditGoalStarted extends EditGoalEvent {
  const EditGoalStarted();
}

// Changed
class EditGoalNameChanged extends EditGoalEvent {
  const EditGoalNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EditGoalTargetAmountChanged extends EditGoalEvent {
  const EditGoalTargetAmountChanged({required this.targetAmount});

  final String targetAmount;

  @override
  List<Object> get props => [targetAmount];
}

class EditGoalCurrentAmountChanged extends EditGoalEvent {
  const EditGoalCurrentAmountChanged({required this.currentAmount});

  final String currentAmount;

  @override
  List<Object> get props => [currentAmount];
}

class EditGoalEndDateChanged extends EditGoalEvent {
  const EditGoalEndDateChanged({required this.endDate});

  final DateTime endDate;

  @override
  List<Object> get props => [endDate];
}

// Added
class EditGoalAmountAdded extends EditGoalEvent {
  const EditGoalAmountAdded({required this.amount});

  final String amount;

    @override
  List<Object> get props => [amount];
}

// Submitted
class EditGoalSubmitted extends EditGoalEvent {
  const EditGoalSubmitted();
}


// Delete
class EditGoalDeleted extends EditGoalEvent {
  const EditGoalDeleted();
}