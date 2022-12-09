import 'dart:io';

import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Account> {}

void main() {
  group('LocalAccountRepository', () {
    late LocalAccountRepository localAccountRepository;
    late Store store;
    late Box<Account> box;

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
          when(() => store.box<Account>()).thenReturn(box);
          expect(LocalAccountRepository(store: store).accountBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Account>()).thenReturn(box);
          localAccountRepository = LocalAccountRepository(store: store);
          try {
            await localAccountRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}








// void main() {
//   late LocalAccountRepository sut;
//   String testsDir;
//   const testsPath = 'obx-avenique-test';
//   late Store store;

//   setUp(() async {
//     //mockStore = MockStore();
//     // getApplicationDocumentsDirectory().then((docsDir) {
//     //   testsDir = p.join(docsDir.path, testsPath);
//     //   Directory(testsDir).delete(recursive: true);
//     //   return openStore(directory: testsDir).then((value) {
//     //     store = value;
//     //     sut = LocalAccountRepository(store: value);
//     //   });
//     // });
//     //sut = LocalAccountRepository(store: store);
//     final docsDir = await getApplicationDocumentsDirectory();
//     testsDir = p.join(docsDir.path, testsPath);
//     Directory(testsDir).delete(recursive: true);
//     store = await openStore(directory: testsDir);
//     sut = LocalAccountRepository(store: store);
//   });

//   // test('test name', () {
//   //   getApplicationDocumentsDirectory().then((value) {
//   //     testsDir = value.path;
//   //     prints(testsDir);
//   //   });
//   // });

//   group('insert', () {
//     test("should success when insert new account that doesn't exist before",
//         () {
//       final account = Account(name: 'test', balance: '0.00');
//       final id = sut.insert(account);
//       expect(id, store.box<Account>().get(id)!.id);
//     });

//     test('tt', () {
//       final account = Account(name: 'test', balance: '0.00');
//       sut.insert(account);
//       expect(sut.insert(account), 9);
//     });
//   });

//   // tearDown(() {
//   //   //store.close();
//   // });

//   // // group('getAll', () {
//   // //   test('check that the return type is a stream of list of account', () {
//   // //     expect(sut.getAll(), const TypeMatcher<Stream<List<Account>>>());
//   // //   });
//   // // });
// }
