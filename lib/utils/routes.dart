import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../app/auth.dart';
import '../presentation/constants/documents.dart';
import '../presentation/screens/chat.dart';
import '../presentation/screens/docs.dart';
import '../presentation/screens/home.dart';
import '../presentation/screens/profile.dart';
import '../presentation/screens/signin.dart';
import '../presentation/screens/signup.dart';
import '../presentation/screens/workshop.dart';

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
        name: 'workshop',
        path: '/workshop',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: WorkshopScreen(),
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
          name: 'docs',
          path: '/docs',
          pageBuilder: (context, state) {
            final document = (state.extra ?? Document.introduction) as Document;
            return NoTransitionPage<void>(
              key: state.pageKey,
              child: DocsScreen(document: document),
            );
          }),
      GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ProfileScreen(),
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
