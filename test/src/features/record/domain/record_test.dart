import 'package:avenique/src/features/record/domain/record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/category/domain/category.dart';

void main() {
  late Record sut;
  late DateTime now = DateTime.now();

  setUp(() {
    sut = Record(
        type: 'Record type', amount: '0.00', note: 'Record note', date: now);
  });
  group('Record initial', () {
    test('Record id should start at 0', () {
      expect(sut.id, 0);
    });

    test('Record type should be "Record type"', () {
      expect(sut.type, 'Record type');
    });
    test('Record amount should be "0.00"', () {
      expect(sut.amount, '0.00');
    });

    test('Record note should be "Record note"', () {
      expect(sut.note, 'Record note');
    });

    test('Record date should be now', () {
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
