import 'package:flutter_test/flutter_test.dart';
import 'package:avenique/src/features/category/domain/category.dart';

void main() {
  late Category sut;

  setUp(() {
    sut = Category(name: 'Test Category name', nature: 'nature');
  });
  group('Category initial', () {
    test('Category id should start at 0', () {
      expect(sut.id, 0);
    });

    test('Category name should be "Test Category name"', () {
      expect(sut.name, 'Test Category name');
    });

    test('nature of category shuld be "nature"', () {
      expect(sut.nature, 'nature');
    });
  });
}