import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/utils/object_box.dart';

import '../domain/account.dart';

abstract class AccountRepository {
  Stream<List<Account>> getAll();
  Future<Account?> getOne(int id);
  Future<List<Account>> getWithName(String name);
  Future<List<Account>> get(Query<Account> query);
  int insert(Account account);
  int update(Account account);
  bool delete(int id);
}

class LocalAccountRepository implements AccountRepository {
  final Store store;
  late Box<Account> accountBox;

  LocalAccountRepository({required this.store}) {
    accountBox = store.box<Account>();
  }

  @override
  Stream<List<Account>> getAll() {
    final query = accountBox.query();
    final stream = query.watch(triggerImmediately: true);
    final accounts = stream.map((query) => query.find());
    return accounts;
  }

  @override
  Future<Account?> getOne(int id) => Future.value(accountBox.get(id));

  @override
  Future<List<Account>> getWithName(String name) {
    final query = accountBox.query(Account_.name.equals(name)).build();
    final result = query.find();
    return Future.value(result);
  }

  @override
  int insert(Account account) => accountBox.put(account, mode: PutMode.insert);

  @override
  int update(Account account) => accountBox.put(account, mode: PutMode.update);

  @override
  bool delete(int id) => accountBox.remove(id);

  @override
  Future<List<Account>> get(Query<Account> query) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
