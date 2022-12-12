import 'package:avenique/objectbox.g.dart';
import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/account/edit/bloc/edit_account_bloc.dart';
import 'package:avenique/src/features/account/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockStore extends Mock implements Store {}

class MockAccountRepository extends Mock implements AccountRepository {}

class MockAccount extends Mock implements Account {}

void main() {
  group('EditAccountBloc', () {
    late EditAccountBloc editAccountBloc;
    late MockStore store;
    late MockAccountRepository accountRepository;
    late MockAccount account;

    setUp(() {
      store = MockStore();
      accountRepository = MockAccountRepository();
      account = MockAccount();

      // editAccountBloc = EditAccountBloc(
      //   store: store,
      //   accountRepository: accountRepository,
      //   account: account,
      // );
    });

    group('constructor', () {
      test('''
          initial state for the EditAccountBloc when not given account is 
          EditAccountState(account: null, name: '', balance: '0', tbdName: Name.pure(), tbdNameStatus: FormzStatus.pure)
          ''', () {
        editAccountBloc = EditAccountBloc(
            store: store, accountRepository: accountRepository, account: null);
        expect(
          editAccountBloc.state,
          const EditAccountState(
            account: null,
            name: '',
            balance: '0',
            tbdName: Name.pure(),
            tbdNameStatus: FormzStatus.pure,
          ),
        );
      });
    });

    group('EditAccoutNameChanged', () {
      late Name tbdName;
      late String name;

      blocTest<EditAccountBloc, EditAccountState>(
        '''
                the bloc should emit EditAccountState() when 
                ''',
        setUp: () {
          name = 'tbdName';
          tbdName = Name.dirty(name);
          when(() => account.name).thenReturn('');
          when(() => account.balance).thenReturn('0');
          editAccountBloc = EditAccountBloc(
              store: store,
              accountRepository: accountRepository,
              account: account);
        },
        build: () => editAccountBloc,
        act: (bloc) => bloc.add(EditAccountNameChanged(tbdName: tbdName.value)),
        expect: () => [
          EditAccountState(
            account: account,
            tbdName: tbdName,
            tbdNameStatus: Formz.validate([tbdName]),
          )
        ],
      );
    });

    tearDown(() {
      editAccountBloc.close();
    });
  });
}
