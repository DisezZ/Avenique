import 'package:avenique/objectbox.g.dart';

import '../domain/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> getAll();
  Future<Category?> getOne(int id);
  int insert(Category category);
  int update(Category category);
  bool deleteUser(int id);
}

class LocalCategoryRepository implements CategoryRepository {
  final Store store;
  late Box<Category> categoryBox;

  LocalCategoryRepository({required this.store}) {
    categoryBox = store.box<Category>();
  }

  @override
  Stream<List<Category>> getAll() {
    final query = categoryBox.query();
    final stream = query.watch(triggerImmediately: true);
    final categories = stream.map((query) => query.find());
    return categories;
  }

  @override
  Future<Category?> getOne(int id) => Future.value(categoryBox.get(id));

  @override
  int insert(Category category) => categoryBox.put(category);

  @override
  int update(Category category) => categoryBox.put(category);

  @override
  bool deleteUser(int id) => categoryBox.remove(id);
}
