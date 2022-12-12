import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/goal/data/goal_repository.dart';
import 'package:avenique/src/features/goal/domain/goal.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Goal> {}

void main() {
  group('LocalBudgetRepository', () {
    late LocalGoalRepository localGoalRepository;
    late Store store;
    late Box<Goal> box;

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
          when(() => store.box<Goal>()).thenReturn(box);
          expect(LocalGoalRepository(store: store).goalBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Goal>()).thenReturn(box);
          localGoalRepository = LocalGoalRepository(store: store);
          try {
            await localGoalRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}