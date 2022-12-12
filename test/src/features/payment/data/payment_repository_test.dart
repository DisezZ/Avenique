import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/payment/data/payment_repository.dart';
import 'package:avenique/src/features/payment/domain/payment.dart';
import 'package:avenique/src/utils/object_box.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class MockStore extends Mock implements Store {}

class MockBox extends Mock implements Box<Payment> {}

void main() {
  group('LocalBudgetRepository', () {
    late LocalPaymentRepository localPaymentRepository;
    late Store store;
    late Box<Payment> box;

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
          when(() => store.box<Payment>()).thenReturn(box);
          expect(LocalPaymentRepository(store: store).paymentBox, isNotNull);
        },
      );
    });

    group('getOne', () {
      const id = 1;

      test(
        'calls get with correct id',
        () async {
          when(() => store.box<Payment>()).thenReturn(box);
          localPaymentRepository = LocalPaymentRepository(store: store);
          try {
            await localPaymentRepository.getOne(id);
          } catch (_) {}
          verify(() => box.get(id)).called(1);
        },
      );
    });
  });
}