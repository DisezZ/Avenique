import 'package:avenique/objectbox.g.dart';

import '../domain/goal.dart';

abstract class GoalRepository {
  Stream<List<Goal>> getAll();
  Future<Goal?> getOne(int id);
  int insert(Goal goal);
  int update(Goal goal);
  bool deleteUser(int id);
}

class LocalGoalRepository implements GoalRepository {
  final Store store;
  late Box<Goal> goalBox;

  LocalGoalRepository({required this.store}) {
    goalBox = store.box<Goal>();
  }

  @override
  Stream<List<Goal>> getAll() {
    final query = goalBox.query();
    final stream = query.watch(triggerImmediately: true);
    final goals = stream.map((query) => query.find());
    return goals;
  }

  @override
  Future<Goal?> getOne(int id) => Future.value(goalBox.get(id));

  @override
  int insert(Goal goal) => goalBox.put(goal);

  @override
  int update(Goal goal) => goalBox.put(goal);

  @override
  bool deleteUser(int id) => goalBox.remove(id);
}
