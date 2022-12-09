// Flutter imports:
import 'package:avenique/main.dart';
import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/account/edit/bloc/edit_account_bloc.dart';
import 'package:avenique/src/features/account/presentation/account_list/account_card_list.dart';
import 'package:avenique/src/features/account/presentation/screen/edit_account_screen.dart';
import 'package:avenique/src/features/record/presentation/screen/edit_record_screen.dart';
import 'package:avenique/src/features/record/presentation/screen/records_overview.dart';
import 'package:avenique/src/routing/app_router.dart';
import 'package:avenique/src/utils/color.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:color_blindness/color_blindness_color_scheme.dart';
import 'package:faker/faker.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../objectbox.g.dart';
import 'features/category/data/category_repository.dart';
import 'features/record/data/record_repository.dart';
import 'utils/object_box.dart';

class MyApp extends StatefulWidget {
  final ObjectBox objectBox;
  MyApp({
    super.key,
    required this.objectBox,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final _appRouter = AppRouter();
  final store = objectBox.store;

  @override
  Widget build(BuildContext context) {
    final _repositoryProviders = [
      RepositoryProvider<Store>.value(
        value: objectBox.store,
      ),
      RepositoryProvider<AccountRepository>(
          create: (_) => LocalAccountRepository(store: store)),
      RepositoryProvider<RecordRepository>(
          create: (_) => LocalRecordRepository(store: store)),
      RepositoryProvider<CategoryRepository>(
          create: (_) => LocalCategoryRepository(store: store)),
    ];

    // Define your seed colors.
    const Color primarySeedColor = Color(0xFF66A3FF);
    const Color secondarySeedColor = Color(0xFFFFD700);
    const Color tertiarySeedColor = Color(0xFF636366);

    // // Make a light ColorScheme from the seeds.
    // final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
    //   brightness: Brightness.light,
    //   primaryKey: primarySeedColor,
    //   secondaryKey: secondarySeedColor,
    //   tertiaryKey: tertiarySeedColor,
    //   tones: FlexTones.material(Brightness.light),
    // );

    // // Make a dark ColorScheme from the seeds.
    // final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
    //   brightness: Brightness.dark,
    //   primaryKey: primarySeedColor,
    //   secondaryKey: secondarySeedColor,
    //   tertiaryKey: tertiarySeedColor,
    //   tones: FlexTones.material(Brightness.dark),
    // );

    final colorBlindnessType = ColorBlindnessType.none;

    final lightScheme = colorBlindnessColorScheme(
      CustomColorScheme.lightScheme,
      colorBlindnessType,
    );
    final darkScheme = colorBlindnessColorScheme(
      CustomColorScheme.darkScheme,
      colorBlindnessType,
    );

    final lightTheme = ThemeData(
      colorScheme: lightScheme,
      scaffoldBackgroundColor: lightScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: lightScheme.primary,
        foregroundColor: lightScheme.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey),
        ),
        elevation: 0,
      ),
    );

    final darkTheme = ThemeData(
      colorScheme: darkScheme,
      //scaffoldBackgroundColor: darkScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: darkScheme.surface,
        foregroundColor: darkScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey),
        ),
        elevation: 0,
      ),
    );

    return MultiRepositoryProvider(
      providers: _repositoryProviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: HomeScreen(title: 'Avenique'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final repo = LocalAccountRepository(store: objectBox.store);

  @override
  Widget build(BuildContext context) {
    final bloc = EditAccountBloc(
      accountRepository: RepositoryProvider.of<AccountRepository>(context),
      account: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),

      body: ListView(
        children: [
          StreamBuilder(
            stream: repo.getAll(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final accounts = snapshot.data!;
                return AccountCardList(accounts: accounts);
              }
            },
          ),
          ElevatedButton(
            // onPressed: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => BlocProvider.value(
            //       value: bloc,
            //       child: AddAccountScreen(),
            //     ),
            //   ),
            // ),
            onPressed: () => Navigator.of(context).push(
              EditAccountScreen.route(context: context),
            ),
            // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            //   builder: (_) => BlocProvider<EditAccountBloc>(
            //     create: (_) => EditAccountBloc(
            //       accountRepository:
            //           RepositoryProvider.of<AccountRepository>(context),
            //       account: null,
            //     ),
            //     child: const AddAccountScreen(),
            //   ),
            // )),
            child: const Text('add account'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(RecordsOverviewScreen.route(context: context)),
            child: const Text('records overview'),
          ),
        ],
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),

      // body: StreamBuilder(
      //   stream: repo.getAll(),
      //   builder: (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else {
      //       final accounts = snapshot.data!;
      //       return AccountCardList(accounts: accounts);
      //     }
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        //onPressed: _incrementCounter,
        onPressed: () async => Navigator.of(context)
            .push(await EditRecordScreen.route(context, null)),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    // return CupertinoPageScaffold(
    //   navigationBar: CupertinoNavigationBar(
    //     leading: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Avenique',
    //           style: TextStyle(
    //             fontSize: 18,
    //             fontWeight: FontWeight.w500,
    //             color: CupertinoTheme.of(context).primaryColor,
    //           ),
    //         )
    //       ],
    //     ),
    //     trailing: CupertinoButton(
    //       onPressed: () {},
    //       padding: EdgeInsets.zero,
    //       child: const Icon(Icons.settings),
    //     ),
    //   ),
    //   child: Scaffold(
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () async => Navigator.of(context)
    //           .push(await EditRecordScreen.route(context, null)),
    //       tooltip: 'Add Record',
    //       backgroundColor: CupertinoTheme.of(context).primaryColor,
    //       child: const Icon(CupertinoIcons.plus),
    //     ),
    //   ),
    // );
  }
}
