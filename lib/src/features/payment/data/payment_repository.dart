import 'package:avenique/objectbox.g.dart';

import '../domain/payment.dart';

abstract class PaymentRepository {
  Stream<List<Payment>> getAll();
  Future<Payment?> getOne(int id);
  int insert(Payment payment);
  int update(Payment payment);
  bool deleteUser(int id);
}

class LocalPaymentRepository implements PaymentRepository {
  final Store store;
  late Box<Payment> paymentBox;

  LocalPaymentRepository({required this.store}) {
    paymentBox = store.box<Payment>();
  }

  @override
  Stream<List<Payment>> getAll() {
    final query = paymentBox.query();
    final stream = query.watch(triggerImmediately: true);
    final payments = stream.map((query) => query.find());
    return payments;
  }

  @override
  Future<Payment?> getOne(int id) => Future.value(paymentBox.get(id));

  @override
  int insert(Payment payment) => paymentBox.put(payment);

  @override
  int update(Payment payment) => paymentBox.put(payment);

  @override
  bool deleteUser(int id) => paymentBox.remove(id);
}
