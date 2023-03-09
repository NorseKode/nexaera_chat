import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nexaera_chat/blocs/authentication/auth.dart';
import 'package:nexaera_chat/blocs/authentication/authentication_bloc.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/blocs/upload_domain/upload_domain_bloc.dart';
import 'package:nexaera_chat/data/repositories/nexaera_repository.dart';
import 'package:nexaera_chat/data/services/authorization_service.dart';
import 'package:nexaera_chat/data/services/firestore_service.dart';
import 'package:nexaera_chat/utils/routes.dart';
import 'package:provider/provider.dart';
import 'data/repositories/domain_repository.dart';
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
  runApp(MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        ChangeNotifierProxyProvider2<AuthenticationService, FirestoreService,
                AuthProvider>(
            create: AuthProvider(),
            update: (context, auth, firestore, authProvider) {
              authProvider.setServices(auth, firestore);
              return authProvider;
            }),
        ProxyProvider<AuthProvider, AppRouter>(
            update: (context, auth, appRouter) => appRouter ?? AppRouter(auth)),
      ],
      child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) =>
                    DomainRepository(context.read<AuthProvider>())),
            RepositoryProvider(create: (context) => NexaeraRepository())
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) =>
                    DomainBloc(context.read<DomainRepository>())),
            BlocProvider(
                create: (context) => UploadDomainBloc(
                    context.read<NexaeraRepository>(),
                    context.read<AuthProvider>())),
          ], child: const MyApp()))));
}

// final providerList = [
//   ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
//   ProxyProvider<AuthProvider, AppRouter>(
//       update: (context, auth, previous) => previous ?? AppRouter(auth)),
// ];

// List<RepositoryProvider> repositoryList = [
//   RepositoryProvider(create: (context) => DomainRepository()),
//   RepositoryProvider(create: (context) => NexaeraRepository())
// ];

// List<BlocProvider> blocList = [
//   BlocProvider(
//       create: (context) => DomainBloc(context.read<DomainRepository>())),
//   BlocProvider(
//       create: (context) => UploadDomainBloc(
//           context.read<NexaeraRepository>(), context.read<AuthProvider>())),
// ];
