// Flutter imports:
import 'package:avenique/main.dart';
import 'package:avenique/src/features/account/data/account_repository.dart';
import 'package:avenique/src/features/account/domain/account.dart';
import 'package:avenique/src/features/account/edit/bloc/edit_account_bloc.dart';
import 'package:avenique/src/features/account/presentation/account_list/account_card_list.dart';
import 'package:avenique/src/features/account/presentation/screen/edit_account_screen.dart';
import 'package:avenique/src/features/goal/data/goal_repository.dart';
import 'package:avenique/src/features/home/presentation/screen/help_screen.dart';
import 'package:avenique/src/features/home/presentation/screen/planning_screen.dart';
import 'package:avenique/src/features/home/presentation/screen/statistic_screen.dart';
import 'package:avenique/src/features/record/presentation/record_list/record_tile.dart';
import 'package:avenique/src/features/record/presentation/screen/edit_record_screen.dart';
import 'package:avenique/src/features/record/presentation/screen/records_overview.dart';
import 'package:avenique/src/utils/color.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:color_blindness/color_blindness_color_scheme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:faker/faker.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../objectbox.g.dart';
import 'features/budget/data/budget_repository.dart';
import 'features/home/presentation/screen/statistic_screen.dart';
import 'features/category/data/category_repository.dart';
import 'features/home/presentation/screen/dashboard_screen.dart';
import 'features/payment/data/payment_repository.dart';
import 'features/record/data/record_repository.dart';
import 'features/setting/bloc/setting_bloc.dart';
import 'utils/object_box.dart';

class MyApp extends StatefulWidget {
  MyApp({
    super.key,
    required this.objectBox,
    required this.sharedPreferences,
  });

  final ObjectBox objectBox;
  final SharedPreferences sharedPreferences;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final store = widget.objectBox.store;
    final _repositoryProviders = [
      RepositoryProvider<Store>.value(
        value: widget.objectBox.store,
      ),
      RepositoryProvider<SharedPreferences>.value(
        value: widget.sharedPreferences,
      ),
      RepositoryProvider<AccountRepository>(
          create: (_) => LocalAccountRepository(store: store)),
      RepositoryProvider<RecordRepository>(
          create: (_) => LocalRecordRepository(store: store)),
      RepositoryProvider<CategoryRepository>(
          create: (_) => LocalCategoryRepository(store: store)),
      RepositoryProvider<GoalRepository>(
          create: (context) => LocalGoalRepository(store: store)),
      RepositoryProvider<BudgetRepository>(
          create: (context) => LocalBudgetRepository(store: store)),
      RepositoryProvider<PaymentRepository>(
          create: (context) => LocalPaymentRepository(store: store)),
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

    const colorBlindnessType = ColorBlindnessType.none;

    // final lightScheme = colorBlindnessColorScheme(
    //   CustomColorScheme.lightScheme,
    //   colorBlindnessType,
    // );
    // final darkScheme = colorBlindnessColorScheme(
    //   CustomColorScheme.darkScheme,
    //   colorBlindnessType,
    // );

    // final lightTheme = ThemeData(
    //   useMaterial3: true,
    //   colorScheme: lightScheme,
    //   scaffoldBackgroundColor: lightScheme.background,
    //   appBarTheme: AppBarTheme(
    //     backgroundColor: lightScheme.primary,
    //     foregroundColor: lightScheme.onPrimary,
    //     elevation: 0,
    //   ),
    //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //     backgroundColor: lightScheme.surface,
    //     selectedItemColor: lightScheme.primary,
    //     //unselectedItemColor: ,
    //   ),
    //   cardTheme: CardTheme(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       side: BorderSide(color: Colors.grey),
    //     ),
    //     elevation: 0,
    //   ),
    // );

    // final darkTheme = ThemeData(
    //   colorScheme: darkScheme,
    //   scaffoldBackgroundColor: darkScheme.background,
    //   appBarTheme: AppBarTheme(
    //     backgroundColor: darkScheme.surface,
    //     foregroundColor: darkScheme.onSurface,
    //     elevation: 1,
    //     shape: Border(bottom: BorderSide(color: Colors.grey)),
    //   ),
    //   cardTheme: CardTheme(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16),
    //       side: BorderSide(color: Colors.grey),
    //     ),
    //     elevation: 1,
    //   ),
    // );

    final brandColor = Color(0xFF66A3FF);
    final settingBloc =
        SettingBloc(sharedPreferences: widget.sharedPreferences);
    settingBloc.add(const SettingStarted());

    return MultiRepositoryProvider(
      providers: _repositoryProviders,
      child: BlocProvider.value(
        value: settingBloc,
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                ColorScheme lightColorScheme;
                ColorScheme darkColorScheme;

                if (state.dynamicColorStatus == DynamicColorStatus.on) {
                  if (lightDynamic != null && darkDynamic != null) {
                    lightColorScheme = lightDynamic.harmonized()..copyWith();
                    lightColorScheme =
                        lightColorScheme.copyWith(secondary: brandColor);
                    darkColorScheme = darkDynamic.harmonized()..copyWith();
                    darkColorScheme =
                        darkColorScheme.copyWith(secondary: brandColor);
                  } else {
                    lightColorScheme =
                        ColorScheme.fromSeed(seedColor: brandColor);
                    darkColorScheme = ColorScheme.fromSeed(
                      seedColor: brandColor,
                      brightness: Brightness.dark,
                    );
                  }
                  lightColorScheme = colorBlindnessColorScheme(
                      lightColorScheme, settingBloc.state.colorBlindnessType);
                  darkColorScheme = colorBlindnessColorScheme(
                      darkColorScheme, settingBloc.state.colorBlindnessType);
                } else {
                  lightColorScheme = colorBlindnessColorScheme(
                      ColorScheme.fromSwatch(primarySwatch: Colors.blue),
                      settingBloc.state.colorBlindnessType);
                  darkColorScheme = colorBlindnessColorScheme(
                      ColorScheme.fromSwatch(
                          primarySwatch: Colors.blue,
                          brightness: Brightness.dark),
                      settingBloc.state.colorBlindnessType);
                }

                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: lightColorScheme,
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    colorScheme: darkColorScheme,
                  ),
                  themeMode: settingBloc.state.themeMode,
                  home: HomeScreen(title: 'Avenique'),
                );
              },
            );
          },
        ),
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
  int _selectedIndex = 0;
  final screens = [
    DashboardScreen(),
    PlanningScreen(),
    StatisticScreen(),
    HelpScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // final bloc = EditAccountBloc(
    //   accountRepository: RepositoryProvider.of<AccountRepository>(context),
    //   account: null,
    // );
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() {
          _selectedIndex = value;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.developer_board),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_flags_rounded),
            label: 'Planning',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Statistic',
          ),
          NavigationDestination(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}
