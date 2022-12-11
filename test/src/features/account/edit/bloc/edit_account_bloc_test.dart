import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avenique/src/features/account/edit/bloc/edit_account_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

class MockAccount extends Mock implements Account {}

void main() {
  late MockAccountRepository mockAccountRepository;
  late MockAccount mockAccount;
  late EditAccountBloc editAccountBloc;

  group('EditAccountBloc', () {
    setUp(() {
      mockAccountRepository = MockAccountRepository();
      mockAccount = MockAccount();
    });

    test((''), () {
      editAccountBloc = EditAccountBloc(
          accountRepository: mockAccountRepository, account: mockAccount);
    });

    //final accountResult = AccountResult();
  });
}
