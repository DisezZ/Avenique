import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../objectbox.g.dart';
import '../../../../utils/convert.dart';
import '../../data/goal_repository.dart';
import '../../domain/goal.dart';

part 'edit_goal_event.dart';
part 'edit_goal_state.dart';

class EditGoalBloc extends Bloc<EditGoalEvent, EditGoalState> {
  EditGoalBloc({
    required Store store,
    required GoalRepository goalRepository,
    required Goal? goal,
  })  : _store = store,
        _goalRepository = goalRepository,
        super(EditGoalState(
          goal: goal,
          name: goal?.name ?? '',
          targetAmount: goal?.targetAmount ?? '0',
          currentAmount: goal?.currentAmount ?? '0',
          endDate: goal?.endDate ?? DateTime.now(),
        )) {
    on<EditGoalStarted>(_onEditGoalStarted);
    on<EditGoalNameChanged>(_onEditGoalNameChanged);
    on<EditGoalTargetAmountChanged>(_onEditGoalTargetAmountChanged);
    on<EditGoalCurrentAmountChanged>(_onEditGoalCurrentAmountChanged);
    on<EditGoalEndDateChanged>(_onEditGoalEndDateChanged);
    on<EditGoalAmountAdded>(_onEditGoalAmountAdded);
    on<EditGoalSubmitted>(_onEditGoalSubmitted);
    on<EditGoalDeleted>(_onEditGoalDeleted);
  }

  final Store _store;
  final GoalRepository _goalRepository;

  void _onEditGoalStarted(
    EditGoalStarted event,
    Emitter<EditGoalState> emit,
  ) {}

  void _onEditGoalNameChanged(
    EditGoalNameChanged event,
    Emitter<EditGoalState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onEditGoalTargetAmountChanged(
    EditGoalTargetAmountChanged event,
    Emitter<EditGoalState> emit,
  ) {
    emit(state.copyWith(targetAmount: event.targetAmount));
  }

  void _onEditGoalCurrentAmountChanged(
    EditGoalCurrentAmountChanged event,
    Emitter<EditGoalState> emit,
  ) {
    emit(state.copyWith(currentAmount: event.currentAmount));
  }

  void _onEditGoalEndDateChanged(
    EditGoalEndDateChanged event,
    Emitter<EditGoalState> emit,
  ) {
    emit(state.copyWith(endDate: event.endDate));
  }

  void _onEditGoalAmountAdded(
    EditGoalAmountAdded event,
    Emitter<EditGoalState> emit,
  ) {
    try {
      final goal = state.goal;
      if (goal != null) {
        final currentAmount =
            Convert.convertStringToDecimal(goal.currentAmount);
        final addedAmount = Convert.convertStringToDecimal(event.amount);
        final newAmount =
            Convert.convertDecimalToString(currentAmount + addedAmount);
        goal.currentAmount = newAmount;
        _store.runInTransaction(TxMode.write, () {
          _store.box<Goal>().put(goal);
        });
        print('Old: ${currentAmount.toString()} New: ${newAmount}');
      }
    } catch (e) {
      print('Add Amount Failed');
      emit(state.copyWith(status: EditGoalStatus.failure));
    }
  }

  void _onEditGoalSubmitted(
    EditGoalSubmitted event,
    Emitter<EditGoalState> emit,
  ) {
    try {
      var goal = Goal(
          name: state.name,
          targetAmount: state.targetAmount,
          currentAmount: state.currentAmount,
          endDate: state.endDate);
      if (!state.isNew) {
        goal.id = state.goal!.id;
      }
      _store.runInTransaction(TxMode.write, () {
        _store.box<Goal>().put(goal);
      });
      emit(state.copyWith(status: EditGoalStatus.success));
    } catch (e) {
      print('Put Record Fail!');
      emit(state.copyWith(status: EditGoalStatus.failure));
    }
  }

  void _onEditGoalDeleted(
    EditGoalDeleted event,
    Emitter<EditGoalState> emit,
  ) {
    final goal = state.goal;
    try {
      if (goal != null) {
        _store.runInTransaction(TxMode.write, () {
          _store.box<Goal>().remove(goal.id);
        });
      }
    } catch (e) {
      emit(state.copyWith(status: EditGoalStatus.failure));
    }
  }
}
