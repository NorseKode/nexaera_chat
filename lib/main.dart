import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nexaera_chat/blocs/authentication/auth.dart';
import 'package:nexaera_chat/utils/routes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

Future<void> main() async {
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(providers: providerList, child: const MyApp()));
}

final providerList = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ProxyProvider<AuthProvider, AppRouter>(
      update: (context, auth, previous) => previous ?? AppRouter(auth)),
];

// ElevatedButton(
//             onPressed: () async {
//               var response = await http
//                   .get(Uri.parse('http://localhost:8000/contacts/all/'));
//               print(response.body);
//             },
//             child: Text('Hit API'),
//           ),

