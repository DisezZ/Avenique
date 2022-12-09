import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/budget/domain/budget.dart';
import 'package:avenique/src/features/record/domain/record.dart';
import 'package:avenique/src/features/goal/domain/goal.dart';
import 'package:avenique/src/features/payment/domain/payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Account sut;

  setUp(() {
    sut = Account(name: 'Test Account', balance: '0.00');
  });

  group('Account initial', () {
    test('id should start at 0', () {
      expect(sut.id, 0);
    });

    test('name should be "Test Account"', () {
      expect(sut.name, "Test Account");
    });

    test('balance shuld be "0.00"', () {
      expect(sut.balance, "0.00");
    });

    test('relation to record should be of type to-many relation', () {
      expect(sut.records, const TypeMatcher<ToMany<Record>>());
    });

    test('relation to budget should be of type to-many relation', () {
      expect(sut.budgets, const TypeMatcher<ToMany<Budget>>());
    });

    test('relation to goal should be of type to-many relation', () {
      expect(sut.goals, const TypeMatcher<ToMany<Goal>>());
    });

    test('relation to payment should be of type to-many relation', () {
      expect(sut.payments, const TypeMatcher<ToMany<Payment>>());
    });

  });
}
