import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nexaera_chat/app/auth.dart';
import 'package:nexaera_chat/blocs/domain/domain_bloc.dart';
import 'package:nexaera_chat/blocs/upload_domain/upload_domain_bloc.dart';
import 'package:nexaera_chat/blocs/user/user_bloc.dart';
import 'package:nexaera_chat/data/repositories/authentication_repository.dart';
import 'package:nexaera_chat/data/repositories/chat_repository.dart';
import 'package:nexaera_chat/data/repositories/server_repository.dart';
import 'package:nexaera_chat/data/services/auth_service.dart';
import 'package:nexaera_chat/data/services/firestore_service.dart';
import 'package:nexaera_chat/data/services/websocket_service.dart';
import 'package:nexaera_chat/utils/routes.dart';
import 'package:provider/provider.dart';
import 'blocs/chat/chat_bloc.dart';
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
  var authService = AuthenticationService();
  var firestore = FirestoreService();
  var auth = AuthenticationRepository(authService, firestore);
  var websocket = WebSocketService('');

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(auth),
        ),
        ProxyProvider<AuthProvider, AppRouter>(
            update: (_, auth, appRouter) => appRouter ?? AppRouter(auth)),
      ],
      child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) =>
                    DomainRepository(context.read<AuthProvider>())),
            RepositoryProvider(create: (context) => ServerRepository()),
            RepositoryProvider(create: (context) => ChatRepository(websocket)),
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) =>
                    DomainBloc(context.read<DomainRepository>())),
            BlocProvider(
                create: (context) => UploadDomainBloc(
                    context.read<ServerRepository>(),
                    context.read<AuthProvider>(),
                    context.read<DomainRepository>())),
            BlocProvider(
                create: (context) => ChatBloc(context.read<ServerRepository>(),
                    context.read<ChatRepository>())),
            BlocProvider(create: (context) => UserBloc(auth))
          ], child: const MyApp()))));
}
