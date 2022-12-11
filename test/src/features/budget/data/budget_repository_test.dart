import 'dart:io';

import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/budget/data/budget_repository.dart';
import 'package:avenique/src/features/budget/domain/budget.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Budget> {}

void main() {
  group('LocalBudgetRepository', () {
    late LocalBudgetRepository localBudgetRepository;
    late Store store;
    late Box<Budget> box;

    setUp(() {
      store = MockStore();
      box = MockBox();
      // when(() => store.box()).thenReturn(box);
      //localAccountRepository = LocalAccountRepository(store: store);
    });

    group('constructor', () {
      test(
        'instatntiates internal box',
        () async {
          when(() => store.box<Budget>()).thenReturn(box);
          expect(LocalBudgetRepository(store: store).budgetBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Budget>()).thenReturn(box);
          localBudgetRepository = LocalBudgetRepository(store: store);
          try {
            await localBudgetRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}
