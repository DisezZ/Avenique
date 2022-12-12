import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/record/data/record_repository.dart';
import 'package:avenique/src/features/record/domain/record.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Record> {}

void main() {
  group('LocalRecordRepository', () {
    late LocalRecordRepository localRecordRepository;
    late Store store;
    late Box<Record> box;

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
          when(() => store.box<Record>()).thenReturn(box);
          expect(LocalRecordRepository(store: store).recordBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Record>()).thenReturn(box);
          localRecordRepository = LocalRecordRepository(store: store);
          try {
            await localRecordRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}
