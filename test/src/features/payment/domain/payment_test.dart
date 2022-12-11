import 'package:avenique/src/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/category/domain/category.dart';

void main() {
  late Payment sut;
  late DateTime now = DateTime.now();

  setUp(() {
    sut = Payment(
        type: 'Payment type', name: 'Payment name', amount: '0.00', date: now);
  });
  group('Payment initial', () {
    test('Payment id should start at 0', () {
      expect(sut.id, 0);
    });

    test('Payment type should be "Payment type"', () {
      expect(sut.type, 'Payment type');
    });
    test('Payment name should be "Payment name"', () {
      expect(sut.name, 'Payment name');
    });

    test('Payment amount should be "0.00"', () {
      expect(sut.amount, '0.00');
    });

    test('Payment date should be now', () {
      expect(sut.date, now);
    });

    test('relation to account should be of type to-one relation', () {
      expect(sut.account, const TypeMatcher<ToOne<Account>>());
    });

    test('relation to category should be of type to-one relation', () {
      expect(sut.category, const TypeMatcher<ToOne<Category>>());
    });
  });
}
