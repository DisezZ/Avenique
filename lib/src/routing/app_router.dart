
import 'package:avenique/src/features/account/presentation/screen/edit_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app.dart';

// class AppRouter {
//   final _EditAccountBloc = EditAccountBloc();

//   Route onGeneratedRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case '/':
//         return MaterialPageRoute(
//             builder: (_) => HomeScreen(
//                   title: 'Home',
//                 ));
//       case '/account/create':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider<EditAccountBloc>.value(
//                   value: _EditAccountBloc,
//                   child: AddAccountScreen(),
//                 ));
//       case '/account/create/name':
//         return MaterialPageRoute(
//             builder: (_) => BlocProvider<EditAccountBloc>.value(
//                   value: _EditAccountBloc,
//                   child: const AccountNameFormScreen(),
//                 ));
//       default:
//         return MaterialPageRoute(builder: (_) => const Text('Error'));
//     }
//   }

//   void dispose() {
//     _EditAccountBloc.close();
//   }
// }
