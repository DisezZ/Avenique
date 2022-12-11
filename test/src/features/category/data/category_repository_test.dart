import 'dart:io';

import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/category/data/category_repository.dart';
import 'package:avenique/src/features/category/domain/category.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Category> {}

void main() {
  group('LocalBudgetRepository', () {
    late LocalCategoryRepository localCategoryRepository;
    late Store store;
    late Box<Category> box;

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
          when(() => store.box<Category>()).thenReturn(box);
          expect(LocalCategoryRepository(store: store).categoryBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Category>()).thenReturn(box);
          localCategoryRepository = LocalCategoryRepository(store: store);
          try {
            await localCategoryRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}
