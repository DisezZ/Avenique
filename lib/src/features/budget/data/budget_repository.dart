import 'package:avenique/objectbox.g.dart';

import '../domain/budget.dart';

abstract class BudgetRepository {
  Stream<List<Budget>> getAll();
  Future<Budget?> getOne(int id);
  int insert(Budget budget);
  int update(Budget budget);
  bool deleteUser(int id);
}

class LocalBudgetRepository implements BudgetRepository {
  final Store store;
  late Box<Budget> budgetBox;

  LocalBudgetRepository({required this.store}) {
    budgetBox = store.box<Budget>();
  }

  @override
  Stream<List<Budget>> getAll() {
    final query = budgetBox.query();
    final stream = query.watch(triggerImmediately: true);
    final budgets = stream.map((query) => query.find());
    return budgets;
  }

  @override
  Future<Budget?> getOne(int id) => Future.value(budgetBox.get(id));

  @override
  int insert(Budget budget) => budgetBox.put(budget);

  @override
  int update(Budget budget) => budgetBox.put(budget);

  @override
  bool deleteUser(int id) => budgetBox.remove(id);
}
