import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../app/auth.dart';
import '../presentation/constants/documents.dart';
import '../presentation/screens/chat.dart';
import '../presentation/screens/docs.dart';
import '../presentation/screens/error.dart';
import '../presentation/screens/home.dart';
import '../presentation/screens/account.dart';
import '../presentation/screens/signin.dart';
import '../presentation/screens/signup.dart';
import '../presentation/screens/lab.dart';

class AppRouter {
  final AuthProvider auth;

  AppRouter(this.auth);

  late final router = GoRouter(
    routes: [
      GoRoute(
        name: 'start',
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: 'lab',
        path: '/lab',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: LabScreen(),
        ),
      ),
      GoRoute(
        name: 'chat',
        path: '/chat',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChatScreen(),
        ),
      ),
      GoRoute(
        path: '/docs',
        redirect: (context, state) => '/docs/${Document.introduction.name}',
      ),
      GoRoute(
          name: 'docs',
          path: '/docs/:doc',
          pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: DocsScreen(
                  document:
                      Document.values.asNameMap()[state.params['doc']]!))),
      GoRoute(
        name: 'account',
        path: '/account',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const AccountScreen(),
        ),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SignInScreen(),
        ),
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SignUpScreen(),
        ),
      ),
    ],

    redirect: (context, state) {
      //redirect to the login page if the user is not logged in
      var isSigningIn =
          (state.subloc == '/signin' || state.subloc == '/signup');

      if (!auth.isAuthenticated && !isSigningIn) return '/signin';
      if (auth.isAuthenticated && isSigningIn) return '/';

      //add onboarding redirect

      return null;
    },

    //refresh on changes to loginInfo
    refreshListenable: auth,

    errorPageBuilder: (context, state) =>
        NoTransitionPage<void>(key: state.pageKey, child: const ErrorScreen()),
  );
}
