import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../blocs/authentication/auth.dart';
import '../presentation/screens/docs.dart';
import '../presentation/screens/home.dart';
import '../presentation/screens/signin_page.dart';
import '../presentation/screens/signup_page.dart';
import '../presentation/screens/workshop.dart';

class AppRouter {
  final AuthProvider auth;

  AppRouter(this.auth);

  late final router = GoRouter(
    routes: [
      GoRoute(
        name: 'default',
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: 'workshop',
        path: '/workshop',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const WorkshopScreen(),
        ),
      ),
      GoRoute(
        name: 'docs',
        path: '/docs',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DocsScreen(),
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
  );
}
