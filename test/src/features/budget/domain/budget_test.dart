import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/category/domain/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avenique/src/features/budget/domain/budget.dart';
import 'package:avenique/objectbox.g.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Budget sut;

  setUp(() {
    sut = Budget(name: 'Test Budget', amount: '0.00', period: 'day');
  });
  group('Budget initial', () {
    test('Budget id should start at 0', () {
      expect(sut.id, 0);
    });

    test('name should be "Test Budget"', () {
      expect(sut.name, 'Test Budget');
    });

    test('balance should be "0.00"', () {
      expect(sut.amount, '0.00');
    });

    test('relation to accounts should be of type to-many relation', () {
      expect(sut.accounts, const TypeMatcher<ToMany<Account>>());
    });

    test('relation to categories should be of type to-many relation', () {
      expect(sut.categories, const TypeMatcher<ToMany<Category>>());
    });
  });
}
