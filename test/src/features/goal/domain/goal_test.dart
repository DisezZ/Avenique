import 'package:avenique/src/features/goal/domain/goal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Goal sut;
  late DateTime now = DateTime.now();

  setUp(() {
    sut = Goal(
        name: 'Test Goal name',
        targetAmount: '100.00',
        currentAmount: '0.00',
        endDate: now);
  });
  group('Goal initial', () {
    test('Goal id should start at 0', () {
      expect(sut.id, 0);
    });

    test('Category name should be "Test Goal name"', () {
      expect(sut.name, 'Test Goal name');
    });

    test('target amount of goal shuld be "100.00"', () {
      expect(sut.targetAmount, '100.00');
    });

    test('target amount of goal shuld be "0.00"', () {
      expect(sut.currentAmount, '0.00');
    });

    test('end date of goal shuld be this day', () {
      expect(sut.endDate, now);
    });
  });
}
