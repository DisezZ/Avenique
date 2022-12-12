import 'package:avenique/objectbox.g.dart';

import '../domain/record.dart';

abstract class RecordRepository {
  Stream<List<Record>> getAll();
  Future<Record?> getOne(int id);
  int insert(Record record);
  int update(Record record);
  bool delete(int id);
  void addRecord(Record record);
}

class LocalRecordRepository implements RecordRepository {
  final Store store;
  late Box<Record> recordBox;

  LocalRecordRepository({required this.store}) {
    recordBox = store.box<Record>();
  }

  @override
  Stream<List<Record>> getAll() {
    final query = recordBox.query()
      ..order(Record_.date, flags: Order.descending);
    final stream = query.watch(triggerImmediately: true);
    final records = stream.map((query) => query.find());
    return records;
  }

  @override
  Future<Record?> getOne(int id) => Future.value(recordBox.get(id));

  @override
  int insert(Record record) => recordBox.put(record);

  @override
  int update(Record record) => recordBox.put(record);

  @override
  bool delete(int id) => recordBox.remove(id);

  @override
  void addRecord(Record record) {
    store.runInTransaction(TxMode.write, () {
      recordBox.put(record, mode: PutMode.insert);
    });
  }
}
